Return-Path: <glppe-linuxppc-embedded-2@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by ozlabs.org (Postfix) with ESMTP id B7717DDF4E
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  9 Sep 2008 21:50:10 +1000 (EST)
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1Kd1jP-0000Xl-5Y
	for linuxppc-embedded@ozlabs.org; Tue, 09 Sep 2008 11:50:03 +0000
Received: from 85.220.137.251 ([85.220.137.251])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Tue, 09 Sep 2008 11:50:03 +0000
Received: from marwisbo by 85.220.137.251 with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Tue, 09 Sep 2008 11:50:03 +0000
To: linuxppc-embedded@ozlabs.org
From: Martin Kuhnert <marwisbo@gmail.com>
Subject: How to make a simpleImage equivalent in 2.6.24?
Date: Tue, 9 Sep 2008 11:46:42 +0000 (UTC)
Message-ID: <loom.20080909T111617-678@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: news <news@ger.gmane.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

while developing for a Virtex platform I'm used to do

  make simpleImage.virtex405-<myboard>

on recent kernels to get a bootwrapped kernel including the dtb as described
in http://ols.fedoraproject.org/OLS/Reprints-2008/likely2-reprint.pdf.

How to compile a 2.6.24.x kernel to get an equivalent elf file which runs
out of the ram and includes the kernel, the bootwrapper _AND_ the dtb?

As I studied the Makefile in arch/powerpc/boot it looks like

  make zImage.<myboard>

should work. I tried it this in many ways but Make doesn't find the target.

Currently, I'm using "make zImage" and arch/powerpc/boot/wrapper
for this purpose:

  "arch/powerpc/boot/wrapper -o zImage.virtex -p of " \
  "-s arch/powerpc/boot/dts/virtex405-<myboard>.dts " \
  "-C ppc405-402- vmlinux"


Thanks for suggestions!

--
Martin
