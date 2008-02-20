Return-Path: <raul.moreno@telvent.abengoa.com>
Received: from envio.abengoa.com (envio.abengoa.com [217.15.37.68])
	by ozlabs.org (Postfix) with ESMTP id 687CCDDE27
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Feb 2008 01:43:54 +1100 (EST)
Subject: initramfs problem - /init file
To: linuxppc-embedded@ozlabs.org
Message-ID: <OFD6E53986.0FA028A5-ONC12573F5.004F3B41-C12573F5.005101EA@abengoa.com>
Date: Wed, 20 Feb 2008 15:44:22 +0100
From: raul.moreno@telvent.abengoa.com
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



Hello everybody,

I created a tiny root filesystem, just with Busybox, that I want to use=
 as
rootfs through initramfs (and keep it as the final root filesystem).

First of all, I probed this root filesystem using NFS to be sure it wor=
ked
and in fact, it did. Then I created an init file which is a link to
/sbin/init and I inserted the created cpio file with this filesystem in=

CONFIG_INITRAMFS_SOURCE. When I boot the system up, I get the following=

error:

Failed to execute /init

Kernel panic - not syncing: No init found.  Try passing init=3D option =
to
kernel.


If I also tried with an init script instead to a link to /sbin/init, bu=
t
this error happens again.
I think the kernel finds the initramfs right, because if I don't add th=
e
init file, I get a different error:


VFS: Cannot open root device "<NULL>" or unknown-block(0,0)

Please append a correct "root=3D" boot option;


What is the problem with "init"?
Could anyone help me? Thanks in advance,

Ra=FAl Moreno

***********Internet Email Confidentiality Footer*************
This email and any files transmitted with it are confidential and inten=
ded
solely for the use of the organization or individual to whom they are
addressed.  It is expressly forbidden to retransmit or copy email and/o=
r
this  attached files without our permission .  If you are not the
addressee indicated in this message (or responsible for delivery of the=

message to such person), you may not copy or deliver this message
to anyone. In such case, you should destroy this message and kindly
notify the sender by reply email. Please advise immediately if you or
your employer does not consent to Internet email for messages of this
kind.  Opinions, conclusions and other information in this message that=

do not relate to the official business of my firm shall be understood a=
s
neither given nor endorsed by it.=
