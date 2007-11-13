Return-Path: <lokowich@acdstar.com>
Received: from g2host.com (mailfront1.g2host.com [208.42.176.212])
	by ozlabs.org (Postfix) with ESMTP id C8A36DDDFC
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Nov 2007 00:59:59 +1100 (EST)
Received: from [74.95.143.41] (account lokowich@acdstar.com HELO
	[192.168.2.105])
	by mailfront1.g2host.com (CommuniGate Pro SMTP 5.1.10)
	with ESMTPA id 25093316 for linuxppc-embedded@ozlabs.org;
	Tue, 13 Nov 2007 07:59:54 -0600
Message-ID: <4739ADDC.8010402@acdstar.com>
Date: Tue, 13 Nov 2007 07:59:56 -0600
From: lokowich <lokowich@acdstar.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Re: SDRAM failures on MPC5200B
References: <46A0D76E.4030101@acdstar.com>
In-Reply-To: <46A0D76E.4030101@acdstar.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

A follow-up:  The first version of our termination network was based on 
the Lite5200 reference design, but was confirmed by Freescale to be 
inadequate.  We revised the hardware per their errata, terminating both 
ends of the data bus.  This fixed the problem.  Thanks for the helpful 
feedback.

Mark

lokowich wrote:
> We're working on bringing up a MPC5200B version of our original 
> MPC5200 board using U-Boot 1.1.4 configured for Icecube/Lite5200B.  
> Other than the CPU, the board is identical.  The bootloader crashes 
> just after relocation to RAM, often with a Program Check Exception, 
> typically a memory corruption issue.  I noticed failures at different 
> stages after relocation based on content, suggesting problems with 
> upper SDRAM.  If I force the initram to 1/2 the determined size (64MB 
> instead of 128MB), then everything works well through kernel load and 
> initialization.  We've added termination resistors to improve AD 
> signals, to no avail.  Memory tests work fine too.  Any help is 
> appreciated.
>
> Thanks,
> Mark Lokowich
> Systems Engineer
> Advanced Communication Design
> 7901 12th Ave. So.
> Bloomington, MN 55425
> 952-854-4000
> lokowich@acdstar.com
> This email was Anti Virus checked by Astaro Security Gateway. http://www.astaro.com
> This email was Anti Virus checked by Astaro Security Gateway. http://www.astaro.com
> ------------------------------------------------------------------------
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
