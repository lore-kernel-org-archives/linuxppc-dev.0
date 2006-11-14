Return-Path: <vantranbk@yahoo.com.au>
Received: from web33009.mail.mud.yahoo.com (web33009.mail.mud.yahoo.com
	[209.191.69.124]) by ozlabs.org (Postfix) with SMTP id EEFBA67CB9
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 15 Nov 2006 01:25:40 +1100 (EST)
Message-ID: <20061114142538.81112.qmail@web33009.mail.mud.yahoo.com>
Date: Wed, 15 Nov 2006 01:25:38 +1100 (EST)
From: tran vanle <vantranbk@yahoo.com.au>
Subject: Telnet still error
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-2115380243-1163514338=:80283"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-2115380243-1163514338=:80283
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

I use kernel 2.6.11.7 and Ramdisk in ELDK 4.0 (I only edit Ramdisk of ELDK 4.0 for login (use ttyCPM0) ).
   - If I run  telnetd(of busybox) daemon  in /sbin/telnetd
        when I telnet to this board ,i receive
        telnetd: bind: Address already in use 
   - If I run  telnetd daemon  in /usr/sbin/in.telnetd 
        when I telnet to this board ,i receive
        telnetd: All network ports in use!
I receive reply mail of  "Kalle Pokki" <kalle.pokki@iki.fi>

>I vaguely remember trying the same thing with a MPC860 target and
>having the same error messages. If I remember it right, the message
>was caused by missing PAM libraries or something like that. I can't
>give you any specific instructions, but you might want to google for
>PAM and telnet to get some more directions.


and I configured PAM as the following:(base on )
/etc/pam.d/telnet

auth       requisite  pam_securetty.so
auth       required   pam_unix.so
account    required   pam_unix.so
password   required   pam_unix.so md5
session    required   pam_unix.so


but still receive the same

What cause this error ?
Thanks a lot    


 Send instant messages to your online friends http://au.messenger.yahoo.com 
--0-2115380243-1163514338=:80283
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

I use kernel 2.6.11.7 and Ramdisk in ELDK 4.0 (I only edit Ramdisk of ELDK 4.0 for login (use ttyCPM0) ).<br>&nbsp;&nbsp; - If I run&nbsp; telnetd(of busybox) daemon&nbsp; in /sbin/telnetd<br>&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;when I telnet to this board ,i receive<br>&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;telnetd: bind: Address already in use <br>&nbsp;&nbsp; - If I run&nbsp; telnetd daemon&nbsp; in /usr/sbin/in.telnetd <br>&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;when I telnet to this board ,i receive<br>&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;telnetd: All network ports in use!<br>I receive reply mail of&nbsp; "Kalle Pokki" &lt;kalle.pokki@iki.fi&gt;<br><br>&gt;I vaguely remember trying the same thing with a MPC860 target and<br>&gt;having the same error messages. If I remember it right, the message<br>&gt;was caused by missing PAM libraries or something like that. I can't<br>&gt;give you any specific instructions, but you might want to google for<br>&gt;PAM and telnet to
 get some more directions.<br><br><br>and I configured PAM as the following:(base on )<br>/etc/pam.d/telnet<br><br>auth&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; requisite&nbsp; pam_securetty.so<br>auth&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; required&nbsp;&nbsp; pam_unix.so<br>account&nbsp;&nbsp;&nbsp; required&nbsp;&nbsp; pam_unix.so<br>password&nbsp;&nbsp; required&nbsp;&nbsp; pam_unix.so md5<br>session&nbsp;&nbsp;&nbsp; required&nbsp;&nbsp; pam_unix.so<br><br><br>but still receive the same<br><br>What cause this error ?<br>Thanks a lot&nbsp;&nbsp; &nbsp;<br><br><p>&#32;Send instant messages to your online friends http://au.messenger.yahoo.com 
--0-2115380243-1163514338=:80283--
