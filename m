Return-Path: <kumar.gala@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 06F2367A64
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 Mar 2005 18:34:44 +1100 (EST)
In-Reply-To: <4227E990.5050604@semicircular.net>
References: <4227E990.5050604@semicircular.net>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <3230bc3ecd1bc416a32ffd532c6e8a42@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Fri, 4 Mar 2005 01:34:32 -0600
To: "Adam Kent" <adam@semicircular.net>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] PCI bridge support for MPC8272 and PQ2FADS
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Adam,

I'm not aware of any such patches (unless Vitaly has some).  If you do 
this, please port it against linux-2.5 instead of linuxppc-2.5.  Also, 
if you send me the patches and I will ensure they get pushed upstream 
into the stock kernel.

thanks

- kumar

On Mar 3, 2005, at 10:52 PM, Adam Kent wrote:

> Vitaly Bordug wrote:
>  > This patch adds PCI bridge support for MPC8272 and PQ2FADS to the
>  > current linuxppc-2.4 tree. Actually it has been tested with 8272, 
> but
>  > PQ2 _should_ also work, though it will complain that host bridge ID 
> is
>  > unrecognized.
>
> This patch is against the linuxppc-2.4 tree, but it seems there is
>  also no support for the MPC8272ADS / PQ2FADS PCI bridge in the
> linuxppc-2.5 kernel tree.
>
> Before I go and "forward" port it myself, are there any other patches
> out there that add support for PCI for the 8272ADS under the 2.6 
> kernel?
>
> Thanks,
>  Adam Kent
>  _______________________________________________
> Linuxppc-embedded mailing list
>  Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
