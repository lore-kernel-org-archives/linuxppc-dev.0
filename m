Return-Path: <jonsmirl@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.182])
	by ozlabs.org (Postfix) with ESMTP id 479CCDDE17
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 30 Sep 2007 15:06:01 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id a29so7351431pyi
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 29 Sep 2007 22:05:59 -0700 (PDT)
Message-ID: <9e4733910709292205p7b1cdda9m661b241908fdedab@mail.gmail.com>
Date: Sun, 30 Sep 2007 01:05:58 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Efika, initrd and current kernel
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I'm trying to boot a current kernel on the Efika like this:
boot hd:0 efika init=/linuxrc root=/dev/ram0 looptype=squashfs
loop=/squashfs.img cdroot

It is not finding the initrd.
I added some printks and start_initrd is not getting set.

The 2.6.19 gentoo kernel described here boots and finds the same initrd
http://gentoo-wiki.com/Efika

Something is missing in the hand off from the OF to the kernel code.
I'm poking around in powerpc/kernel/prom_init.c
looking for answers.

-- 
Jon Smirl
jonsmirl@gmail.com
