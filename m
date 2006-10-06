Return-Path: <jaap.dejong@nedap.com>
Received: from smtp2.nedap.com (smtp2.nedap.com [213.160.213.92])
	by ozlabs.org (Postfix) with ESMTP id 03C6867EAA
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  6 Oct 2006 23:44:47 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Linuxppc-embedded Digest, Vol 26, Issue 13
Date: Fri, 6 Oct 2006 15:44:45 +0200
Message-ID: <6915D0AE8B9047438F320B466AE30FDD798359@nvs0003.nedap.local>
From: "Jaap de Jong" <jaap.dejong@nedap.com>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Not sure...
I have not been playing with 2.6 kernels but this looks a lot like
the problems I found when trying to get the 2.4 kernel to work.
Default for the avnet v4fx12 is to use the opb bus as raminterface.
You should explicitly select the plb bus...

Jaap de Jong

----------------------------------------------------------------------

Message: 1
Date: Fri, 06 Oct 2006 10:33:53 +0900
From: Yoshio Kashiwagi <kashiwagi@co-nss.co.jp>
Subject: Re: Problem with initrd
To: Glenn.G.Hart@us.westinghouse.com, linuxppc-embedded@ozlabs.org
Message-ID: <JF2006100610335316.6823078@co-nss.co.jp>
Content-Type: text/plain; charset=3DISO-2022-JP

Glenn-San,

Are you developing by the custom-made hardware of V4FX12?
If the 16-bit memory controller is used, it may have a problem in the
memory controller.

Can you try the memory controller of http://www.xilinx.com/mpmc2?
I confirmed that the 16-bit memory controller of MPMC2 worked correctly
by Linux. Or I can send the ramdisk image for 2.6.17.3 kernel which I am
using to you.

Yoshio kashiwagi - Nissin Systems
