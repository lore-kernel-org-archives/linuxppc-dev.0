Return-Path: <s.maiti@tcs.com>
Received: from inkolg01.tcs.com (inkolg01.tcs.com [203.197.96.54])
	by ozlabs.org (Postfix) with ESMTP id A4C8167BA1
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  8 Dec 2006 15:56:13 +1100 (EST)
To: U-Boot-Users@lists.sourceforge.net
Subject: 
MIME-Version: 1.0
From: s.maiti@tcs.com
Message-ID: <OF015105FC.2114DF88-ON6525723E.001A1966-6525723E.001A23E0@tcs.com>
Date: Fri, 8 Dec 2006 10:15:58 +0530
Content-Type: multipart/alternative;
	boundary="=_alternative 001A235B6525723E_="
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multipart message in MIME format.
--=_alternative 001A235B6525723E_=
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"

Hi All,
I am using linux-2.4.25 kernel and ELDK3.1 toolchain for my Custom 
PPC(MPC8260) board. I am using the ramdisk image which is come along with 
the ELDK.

With this board is coming up.
Now I wanted to upgrade my busybox-0.65 to busybox-1.1.3
 So I installed the new busy box and copied the bin sbin and usr 
directories  to the filesytem . When i tried to do tftp it is giving 
following errors.

Looking up port of RPC 100005/1 on 172.18.18.59
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 56k init
kmod: runaway modprobe loop assumed and stopped
kmod: runaway modprobe loop assumed and stopped
kmod: failed to exec /sbin/modprobe -s -k binfmt-4c46, errno = 8 (endless 
loop)


With the old busybox it is working fine.

Please kindly help me in this regard.

Thanks and regards,
Souvik Maiti
Tata Consultancy Services
Mailto: s.maiti@tcs.com
Website: http://www.tcs.com
=====-----=====-----=====
Notice: The information contained in this e-mail
message and/or attachments to it may contain 
confidential or privileged information. If you are 
not the intended recipient, any dissemination, use, 
review, distribution, printing or copying of the 
information contained in this e-mail message 
and/or attachments to it are strictly prohibited. If 
you have received this communication in error, 
please notify us by reply e-mail or telephone and 
immediately and permanently delete the message 
and any attachments. Thank you



--=_alternative 001A235B6525723E_=
Content-Transfer-Encoding: 7bit
Content-Type: text/html; charset="us-ascii"


<br><font size=2 face="sans-serif">Hi All,</font>
<br><font size=2 face="sans-serif">I am using linux-2.4.25 kernel and ELDK3.1
toolchain for my Custom PPC(MPC8260) board. I am using the ramdisk image
which is come along with the ELDK.</font>
<br>
<br><font size=2 face="sans-serif">With this board is coming up.</font>
<br><font size=2 face="sans-serif">Now I wanted to upgrade my busybox-0.65
to busybox-1.1.3</font>
<br><font size=2 face="sans-serif">&nbsp;So I installed the new busy box
and copied the bin sbin and usr directories &nbsp;to the filesytem . When
i tried to do tftp it is giving following errors.</font>
<br>
<br><font size=2 face="sans-serif">Looking up port of RPC 100005/1 on 172.18.18.59</font>
<br><font size=2 face="sans-serif">VFS: Mounted root (nfs filesystem).</font>
<br><font size=2 face="sans-serif">Freeing unused kernel memory: 56k init</font>
<br><font size=2 face="sans-serif">kmod: runaway modprobe loop assumed
and stopped</font>
<br><font size=2 face="sans-serif">kmod: runaway modprobe loop assumed
and stopped</font>
<br><font size=2 face="sans-serif">kmod: failed to exec /sbin/modprobe
-s -k binfmt-4c46, errno = 8 (endless loop)</font>
<br>
<br>
<br><font size=2 face="sans-serif">With the old busybox it is working fine.</font>
<br>
<br><font size=2 face="sans-serif">Please kindly help me in this regard.</font>
<br>
<br><font size=2 face="sans-serif">Thanks and regards,</font>
<br><font size=2 face="sans-serif">Souvik Maiti<br>
Tata Consultancy Services<br>
Mailto: s.maiti@tcs.com<br>
Website: http://www.tcs.com</font><pre>=====-----=====-----=====
Notice: The information contained in this e-mail
message and/or attachments to it may contain 
confidential or privileged information. If you are 
not the intended recipient, any dissemination, use, 
review, distribution, printing or copying of the 
information contained in this e-mail message 
and/or attachments to it are strictly prohibited. If 
you have received this communication in error, 
please notify us by reply e-mail or telephone and 
immediately and permanently delete the message 
and any attachments. Thank you


</pre>
--=_alternative 001A235B6525723E_=--
