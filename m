Return-Path: <perka@dtek.chalmers.se>
Received: from anubis.medic.chalmers.se (anubis.medic.chalmers.se
	[129.16.30.218]) by ozlabs.org (Postfix) with ESMTP id A6FB2DDE36
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Dec 2007 01:16:04 +1100 (EST)
Received: from webmail.chalmers.se (styx.ita.chalmers.se [129.16.222.185])
	by mail.chalmers.se (Postfix) with ESMTP id 8E11A19FF1
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Dec 2007 14:56:53 +0100 (CET)
Message-ID: <5797.213.15.68.47.1198072613.squirrel@webmail.chalmers.se>
Date: Wed, 19 Dec 2007 14:56:53 +0100 (CET)
Subject: Linux on Freescale e200
From: "Per-Erik Johansson" <perka@dtek.chalmers.se>
To: linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi

I'm wondering if someone has ever tried to get Linux running on a
Freescale e200 core?
I found a patch to the Linux kernel from back in 2005:
(http://linux.derkeiler.com/Mailing-Lists/Kernel/2005-06/5731.html)
And it is listed as a processor type in Linux-2.6.23.11
I know that there has been some confusion about e200 and e500 cores, old
e200 renamed to e500, but from what I understand the e200 core now listed
in the kernel is the one currently being used in MPC55xx

I'm having a MPC5554, e200z6 core, that I'm supposed to get Linux running
on (master thesis) and any pointers and tips are appreciated.
Just finished porting/tweaking the Redboot boot loader, and I'm now moving
on to the Linux (porting?) part.

Cheers
 Per-Erik
