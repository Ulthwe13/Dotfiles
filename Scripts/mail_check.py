#!/usr/bin/python
# Connects to imap server and checks for unread mail, sends the 
# subject and sender from each unread email as a notification 
# using libnotify and finally saves a total count of unread mail
# to the file mail.txt
import imaplib
import email
import os

imap_server = "<imap_address>"
imap_user = "<imap_email>"
imap_password = "imap_password"
filename = "mail.txt"


def save_mail_count(n, filename):
	if not os.path.exists(filename):
		file(filename, 'w').close()
	f = open(filename, 'r+')
	f.seek(0)
	f.truncate()
	f.write(str(n))
	f.close()



mail = imaplib.IMAP4_SSL(imap_server)

(retcode, capabilities) = mail.login(imap_user, imap_password)
mail.list()
mail.select('inbox', readonly=True)

n = 0
(retcode, messages) = mail.search(None, '(UNSEEN)')
if retcode == 'OK':
   for num in messages[0].split():
      n = n + 1
      typ, data = mail.fetch(num,'(RFC822)')
      for response_part in data:
         if isinstance(response_part, tuple):
             original = email.message_from_string(response_part[1])
             message  = original['From']+original['Subject']
             os.system("/usr/bin/notify-send '" + message +"'")

save_mail_count(n, filename)
