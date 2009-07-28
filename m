Return-Path: <bj@mhlabs.com>
Received: from mhsecure.serverpowered.net (mhsecure.serverpowered.net
	[204.8.182.18])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 43B4FB70CF
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 28 Jul 2009 17:11:59 +1000 (EST)
Received: from ool-457626d4.dyn.optonline.net ([69.118.38.212]
	helo=[192.168.1.103])
	by mhsecure.serverpowered.net with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.69) (envelope-from <bj@mhlabs.com>) id 1MVfiQ-0005r2-Cp
	for linuxppc-dev@lists.ozlabs.org; Tue, 28 Jul 2009 01:59:10 -0400
Message-Id: <06A91D45-B506-44F8-A234-D9E55301349D@mhlabs.com>
From: "B.J. Buchalter" <bj@mhlabs.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Question about tracking freescale patches for Linux
Date: Tue, 28 Jul 2009 02:08:36 -0400
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Folks,

Sorry if this question is out of place for this list -- if it is,  
please point me to the proper place for this sort of question. It just  
seems like this might be the best place to ask.

I am looking at bunch of patches to the 2.6.25 kernel (primarily in  
the drivers) that are provided by freescale as part of the BSP that  
they provide for the MPC837x parts.

Most of these patches are in the 2.6.30 kernel, but a number of them  
are not; these primarily relate to changes to drivers for DMA, the  
Security peripheral and the TSEC controllers.

I have contacted Freescale, but they basically say that they provide  
the BSP, and make no commitments to supporting any other version of  
the linux kernel.

My questions are:

1) is there any way to determine if any these patches are currently  
being worked into the mainline kernel, or if they have been abandoned  
for some reason?

2) Is it worth trying to move these patches up to the head of  
development and trying to get them merged into the mainline kernel, or  
is that really just up to freescale to do?

Again, if there is a better place to be addressing this, please point  
me in that direction.

Thanks in advance!

B.J. Buchalter
Metric Halo
http://www.mhlabs.com
	
