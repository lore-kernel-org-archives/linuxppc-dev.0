Return-Path: <nathael.pajani@ecrin.com>
Received: from smtp-out.completel.net (smtp-out.completel.net [83.145.110.36])
	by ozlabs.org (Postfix) with ESMTP id 5442468639
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 21 Oct 2005 18:22:38 +1000 (EST)
Received: from [192.52.109.152] (unknown [83.145.98.3])
	by smtp-out.completel.net (Postfix) with ESMTP id F3575280071
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 21 Oct 2005 10:03:20 +0200 (CEST)
Message-ID: <4358A131.40303@ecrin.com>
Date: Fri, 21 Oct 2005 10:05:05 +0200
From: Nathael PAJANI <nathael.pajani@ecrin.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: Three-Speed Ethernet support on MPC8560 (CPM2 TSEC)
Reply-To: nathael.pajani@ecrin.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all!

I'm working on a port of linux (2.6.13-2) on an Actis-computer board, 
based on the Freescale MPC8560 Processor.

I solved the problems I had with the init process, and I actually have 
the console (SCC1) and one ethernet controler (FCC3) running.

I will now go on with the Three-Speed Ethernet Controler, and there 
actually seem to be no support for it, but maybe I did not look at the 
right place?

I got another question, about the FCC driver: it uses a "big" structure 
"fcc_enet_t" wich seems to be aimed at stats. This is initialised, but I 
did not find where this is used. Is it?

Thanks.
