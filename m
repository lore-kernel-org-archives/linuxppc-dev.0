Reply-To: <zjzhou@newrocktech.com>
From: "John Zhou" <zjzhou@newrocktech.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: about tinylogin
Date: Fri, 5 Mar 2004 09:54:20 +0800
Message-ID: <000e01c40254$c714bcf0$b702a8c0@newrock2>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I'm meeting a problem:

When I type "su testUser" under shell "ash", it report "Cannot execute
/bin/sh: Permission denied" after I had used command "adduser" to add one
user name.

I used tinylogin(v0.80) for "adduser" and "login" and ash(v0.3.5) for
shell.

My target is based on Linux 2.4.1.

Could anyody give me any hint or point?

Thanks very much!

John

The command process is following:
------------------------------------------------------------------
#adduser John
Changing password for John
Enter the new password (minimum of 5, maximum of 8 characters)
Please use a combination of upper and lower case lette.
Enter new password:
Re-enter new password:
Password changed.
#
# su John
Cannot execute /bin/sh: Permission denied
#
# chmod 777 /bin/sh
#
# su John
Cannot execute /bin/sh: Permission denied
#

-------------------------------------------------------------------

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
