Return-Path: <kumar.gala@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 34C5367A46
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  9 Mar 2005 05:06:57 +1100 (EST)
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B8592E8@ismail.innsys.innovsys.com>
References: <DCEAAC0833DD314AB0B58112AD99B93B8592E8@ismail.innsys.innovsys.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <bf7e05b898c09a2e140f8be26a975118@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Tue, 8 Mar 2005 12:06:48 -0600
To: "Rune Torgersen" <runet@innovsys.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Lots of memory on 826x
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I would start looking at what addresses are getting assigned for 
VMALLOC vs any io_block_mapping() calls.  I know I've had problems with 
large amount of memory in systems if the virt addrs allocated in 
io_block_mapping calls conflict with vmalloc addrs.

- kumar

On Mar 8, 2005, at 11:33 AM, Rune Torgersen wrote:

> Anybody know how to get more than 512MB (1-2GB) of RAM to work with
>  2.6.11 on a 8265?
>
> Weird stuff and crashes keep happening on kernel start (vmalloc out of
> memory, and a pci driver ups) when I tell the kernel I have more than
>  512MB of ram.
> The pci craches happens when I tell the kernel I have 740-760MB or 
> more.
>
> Any idea of where to start to look for this?
>
> Rune Torgersen
>  System Developer
>  Innovative Systems LLC
>  1000 Innovative Drive
>  Mitchell, SD 57301
>  Ph: 605-995-6120
>  www.innovsys.com
> _______________________________________________
> Linuxppc-embedded mailing list
>  Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
