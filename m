Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id B1B99DDEE1
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Mar 2008 06:43:33 +1100 (EST)
Message-ID: <47CB0363.6000705@pikatech.com>
Date: Sun, 02 Mar 2008 14:43:31 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH 3/2][NEWEMAC] Use status property for unused/unwired EMACs
References: <20080301081600.74598ce4@zod.rchland.ibm.com>
	<20080301084140.7abc703e@zod.rchland.ibm.com>
In-Reply-To: <20080301084140.7abc703e@zod.rchland.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Josh Boyer wrote:
> Convert ibm_newemac to use the of_device_is_available function when checking
> for unused/unwired EMACs.  We leave the current check for an "unused" property
> to maintain backwards compatibility for older device trees.  Newer device
> trees should simply use the standard "status" property in the EMAC node.
>
> The taishan DTS file is updated to reflect this.
>   
What is the advantage of documenting unwired devices? I ask because the 
taco does not have emac1 connected. I handle it by not defining emac1 in 
the dts file.

Is it better to document it and disable it? Or is this mainly for 
reference boards to show that while the PPC supports to emacs, only one 
is enabled on the reference board?

i.e. We want reference design boards to show what *could* be done, but 
production boards to show what *is* done?

Cheers,
   Sean
