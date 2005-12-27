Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id 8EE096893C
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Dec 2005 03:30:35 +1100 (EST)
From: David Jander <david.jander@protonic.nl>
To: Wolfgang Denk <wd@denx.de>
Date: Tue, 27 Dec 2005 17:30:28 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200512271730.28563.david.jander@protonic.nl>
Cc: linuxppc-embedded@ozlabs.org
Subject: Which CAN driver to port to for PPC
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi,

We have developed CAN hardware based on the Philips SJA1000 controller hooked 
to a MPC8xx based processor board. Now we want to write driver support for 
it. My first try was lincan-0.3.1, which seemed quite well written at first 
glance. Porting was easy too, and the driver works fine on our board with the 
latest kernel (2.6.14).
But.... this driver lacks a proper way of checking the status of the CAN 
controller from userspace :-( Not that nice after all!

Then I see on the DENX website, mention of Rubini's OCAN (mostly useless to 
us), and Peak's PCAN drivers (there is a port for MPC5200 on DENX's site). No 
word about lincan, though.

The reason I suppose is, someone already figured out that lincan is not a good 
choice for whatever reason (status reportability ??), right?

Before beginning to re-invent wheels and re-discover known problems in certain 
CAN driver architectures, could someone please point me to the right place to 
start looking for answers (if that place exists) or just give the answer, 
opinion or experience with one of PeakCAN, lincan, can4linux, etc...?

I am again puzzeled about which way to go.

Thanks for any advice,

-- 
David Jander
Protonic Holland.
