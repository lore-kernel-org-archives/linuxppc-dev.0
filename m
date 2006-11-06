Return-Path: <tnt@246tNt.com>
Received: from outmx002.isp.belgacom.be (outmx002.isp.belgacom.be
	[195.238.5.52])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BFF4E67CAF
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  6 Nov 2006 20:26:17 +1100 (EST)
Received: from outmx002.isp.belgacom.be (localhost [127.0.0.1])
	by outmx002.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id kA69Q5VB024097
	for <linuxppc-embedded@ozlabs.org>; Mon, 6 Nov 2006 10:26:05 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <454EFFA4.4020909@246tNt.com>
Date: Mon, 06 Nov 2006 10:25:56 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Roman Fietze <roman.fietze@telemotive.de>
Subject: Re: [PATCH] Add MPC52xx PIO/ATA support for arch/powerpc
References: <20061105105325.44e7287f.nd@bplan-gmbh.de>
	<200611061013.43676.roman.fietze@telemotive.de>
In-Reply-To: <200611061013.43676.roman.fietze@telemotive.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Roman Fietze wrote:
> Hallo,
>
> On Sunday 05 November 2006 12:57, Nicolas DET wrote:
>
>   
>> This patch adds ATA/PIO support for Freescale MPC5200 plaforms.
>>     
>
> Assumed I've got a preliminary version of an MPC5200 ATA driver with
> BestComm ATA support (besides a FEC driver with DMA support as well)
> mainly based on code from Sylvain Munaut, Dale Farnsworth and John
> Rigby.
>
> Would you recommend posting those patches here? They are working on
> our platform, any comment would be appreciated.
>   
You can post it won't hurt.
But bestcomm will change for it's arch/powerpc transition so they will need
adaptation ...


   Sylvain
