Return-Path: <jacmet@sunsite.dk>
Received: from hoboe1bl1.telenet-ops.be (hoboe1bl1.telenet-ops.be
	[195.130.137.72]) by ozlabs.org (Postfix) with ESMTP id 4E2DC682C0
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 21 Sep 2005 16:40:05 +1000 (EST)
To: glikely@gmail.com
References: <528646bc05091000377417dc16@mail.gmail.com>
	<87vf0vselw.fsf@p4.48ers.dk>
	<528646bc050920133519382674@mail.gmail.com>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Wed, 21 Sep 2005 08:13:41 +0200
In-Reply-To: <528646bc050920133519382674@mail.gmail.com> (Grant Likely's
	message of "Tue, 20 Sep 2005 14:35:20 -0600")
Message-ID: <87aci77xt6.fsf@p4.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH 2/2] Add support for MEMEC 2VP30-FF1152 eval board with
 simple FPGA design
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>>>>> "Grant" == Grant Likely <glikely@gmail.com> writes:

 Grant> No problem.  I need to go back and review this code anyway to
 Grant> determine if any of it should be split out into common
 Grant> routines for all v2p boards.

Ok.

 Grant> Hey, do you have any drivers for the common 'stock' v2p device
 Grant> cores ported to 2.6 for your board? (like Ethernet, PS/2,
 Grant> framebuffer, etc) I'm about to start porting the SystemACE
 Grant> driver and I also need Ethernet and PS/2 devices, but I don't
 Grant> want to duplicate if anyone has already done the work.

Unfortunately not. We don't use any of the Xilinx IP cores (except
serial/emc), so I haven't had much of an incentive to do the work.

-- 
Bye, Peter Korsgaard
