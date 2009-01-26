Return-Path: <jhautbois@gmail.com>
Received: from mail-ew0-f21.google.com (mail-ew0-f21.google.com
	[209.85.219.21]) by ozlabs.org (Postfix) with ESMTP id EC532DDF4B
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Jan 2009 21:22:58 +1100 (EST)
Received: by ewy14 with SMTP id 14so365675ewy.9
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Jan 2009 02:22:56 -0800 (PST)
MIME-Version: 1.0
Date: Mon, 26 Jan 2009 11:17:05 +0100
Message-ID: <8cad0aa0901260217u5a981c77gc09caba76cce32a7@mail.gmail.com>
Subject: Help needed with initramfs
From: Jean-Michel Hautbois <jhautbois@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: multipart/alternative; boundary=0015174c46465cfea30461600ac3
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--0015174c46465cfea30461600ac3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi everybody !

I have a working Kernel with a NFS mounted root filesystem.
I am trying to use my root file system, but with the use of initramfs.

Compiling the kernel is not a problem, but when booting, I have the
following error:

"Insufficient memory for kernel at address 0! (_start=00400000, uncompressed
size=005a0b0c)"

I understand that my load address is 0x400000 and that the image is too big,
but I can't find where this load adress is defined.
It seems (from the .../arch/powerpc/boot/wrapper file) that this adress is
calculated from the _start adress in the objfile.

Is it possible to change this adress ?
What can I do (with the idea of not reducing the size of my rootfs) ?

Thanks in advance !
Best Regards,
JM

--0015174c46465cfea30461600ac3
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi everybody !<br><br>I have a working Kernel with a NFS mounted root filesystem.<br>I am trying to use my root file system, but with the use of initramfs.<br><br>Compiling the kernel is not a problem, but when booting, I have the following error:<br>
<br>&quot;Insufficient memory for kernel at address 0! (_start=00400000, uncompressed size=005a0b0c)&quot;<br><br>I understand that my load address is 0x400000 and that the image is too big, but I can&#39;t find where this load adress is defined.<br>
It seems (from the .../arch/powerpc/boot/wrapper file) that this adress is calculated from the _start adress in the objfile.<br><br>Is it possible to change this adress ?<br>What can I do (with the idea of not reducing the size of my rootfs) ?<br>
<br>Thanks in advance !<br>Best Regards,<br>JM<br>

--0015174c46465cfea30461600ac3--
