Return-Path: <fabien.fb@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.184])
	by ozlabs.org (Postfix) with ESMTP id 31C9CDDE0A
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  1 Dec 2007 00:33:52 +1100 (EST)
Received: by nf-out-0910.google.com with SMTP id c10so2608686nfd
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 30 Nov 2007 05:33:51 -0800 (PST)
Message-ID: <f8f856500711300533t3bad1c1dxb4ff137534acbccb@mail.gmail.com>
Date: Fri, 30 Nov 2007 14:33:38 +0100
From: fabien <fabien.fb@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: ppcboot and powerpc branch question
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

hi all,

After some problem with my custom board and kernel 2.6.19 about the
init process, i've moved
on 2.6.23 and that had fixed my problems. (related to this post :
http://marc.info/?l=linuxppc-embedded&m=119609022221017&w=2)
Apparently it was a problem with cpm_uart on SMC1.
(http://lkml.org/lkml/2007/9/23/99)
the patch have been integrated in 2.6.23. Now i use this kernel and
busybox works.
I want to migrated my board in powerpc branch instead of ppc (i plan
to use xenomai but in 2.6.23
there is only an adeos patch for piowerpc branch), but i see the use
of a device tree
instead of bd_t struct. I'm a bit disappointed because i also see that
older u-boot (in my case
ppcboot 1.1.5) aren't capable to pass dts to kernel.
Is there a way to keep my old bootloader to boot a powerpc branch kernel ?

Best regards
Fab
