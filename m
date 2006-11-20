Return-Path: <vantranbk@yahoo.com.au>
Received: from web33015.mail.mud.yahoo.com (web33015.mail.mud.yahoo.com
	[209.191.69.130]) by ozlabs.org (Postfix) with SMTP id 9A73367BF5
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 21 Nov 2006 00:40:12 +1100 (EST)
Date: Tue, 21 Nov 2006 00:40:10 +1100 (EST)
From: tran vanle <vantranbk@yahoo.com.au>
Subject: passwd : error
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1250150746-1164030010=:99224"
Message-ID: <730037.99224.qm@web33015.mail.mud.yahoo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-1250150746-1164030010=:99224
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit


Hi all 
I use TQM8xxl board with kernel 2.6.11.7 and Ramdisk of ELDK4.0
command adduser of busybox 1.0
when I login (root) and type command 
adduser van
I receive
adduser: /home/van: Operation not permitted
Changing password for van
Enter the new password (minimum of 5, maximum of 8 characters)
Please use a combination of upper and lower case letters and numbers.
Enter new password:
Re-enter new password:
passwd[74]: an error occurred updating the password file
passwd: An error occurred updating the password file.

and in /home/ I see 
drwxr-sr-x    2 -2       -2           1024 Nov 20  2006 van
in /etc/  i see three file passwd 
-rwxrwxrwx  1 root       root        291 Nov 20 20:20 passwd
-rw-------  1 -2         -2          291 Nov 20 20:20 passwd-
-rwxrwxrwx  1 -2         -2        0 Nov 20 20:20 passwd+

in nfs dir correlative with /home/ i see
drwxr-sr-x  2 4294967294 4294967294 1024 Nov 20 20:20 van
and /etc/
-rwxrwxrwx  1 root       root        291 Nov 20 20:20 passwd
-rw-------  1 4294967294 4294967294  291 Nov 20 20:20 passwd-
-rwxrwxrwx  1 4294967294 4294967294    0 Nov 20 20:20 passwd+


Thanks for all

 Send instant messages to your online friends http://au.messenger.yahoo.com 
--0-1250150746-1164030010=:99224
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<br>Hi all <br>I use TQM8xxl board with kernel 2.6.11.7 and Ramdisk of ELDK4.0<br>command adduser of busybox 1.0<br>when I login (root) and type command <br>adduser van<br>I receive<br>adduser: /home/van: Operation not permitted<br>Changing password for van<br>Enter the new password (minimum of 5, maximum of 8 characters)<br>Please use a combination of upper and lower case letters and numbers.<br>Enter new password:<br>Re-enter new password:<br>passwd[74]: an error occurred updating the password file<br>passwd: An error occurred updating the password file.<br><br>and in /home/ I see <br>drwxr-sr-x&nbsp;&nbsp;&nbsp; 2 -2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1024 Nov 20&nbsp; 2006 van<br>in /etc/&nbsp; i see three file passwd <br>-rwxrwxrwx&nbsp; 1 root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 291 Nov 20 20:20 passwd<br>-rw-------&nbsp; 1 -2 &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
 &nbsp;-2 &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;291 Nov 20 20:20 passwd-<br>-rwxrwxrwx&nbsp; 1 -2 &nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;-2&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;0 Nov 20 20:20 passwd+<br><br>in nfs dir correlative with /home/ i see<br>drwxr-sr-x&nbsp; 2 4294967294 4294967294 1024 Nov 20 20:20 van<br>and /etc/<br>-rwxrwxrwx&nbsp; 1 root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 291 Nov 20 20:20 passwd<br>-rw-------&nbsp; 1 4294967294 4294967294&nbsp; 291 Nov 20 20:20 passwd-<br>-rwxrwxrwx&nbsp; 1 4294967294 4294967294&nbsp;&nbsp;&nbsp; 0 Nov 20 20:20 passwd+<br><br><br>Thanks for all<br><p>&#32;Send instant messages to your online friends http://au.messenger.yahoo.com 
--0-1250150746-1164030010=:99224--
