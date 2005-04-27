Return-Path: <clark@esteem.com>
Received: from mail5.hsphere.cc (mail5.hsphere.cc [216.157.145.25])
	by ozlabs.org (Postfix) with SMTP id 7361C67A6F
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Apr 2005 02:28:42 +1000 (EST)
Message-ID: <426F5987.8050403@esteem.com>
Date: Wed, 27 Apr 2005 02:21:11 -0700
From: Conn Clark <clark@esteem.com>
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Garcia_J=E9r=E9mie?= <GARCIAJ@3il.fr>
References: <D4FDDD1349B5AC46B68FC26AD8AF42D6226B23@exnet.3il.fr>
In-Reply-To: <D4FDDD1349B5AC46B68FC26AD8AF42D6226B23@exnet.3il.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
Subject: Re: Booting linux for 405EP --> mem_pieces_find( ) nightmare
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Jérémie,


Garcia Jérémie wrote:
> Hi everybody,
> I'm tryin to adapt a linux LSP deom Montavista (the one for the 405EP evaluation board) to a proprietary hardware using a 405EP.
> Unfortunately, it is not as easy as I thought. Here is my problem:
> To load our linux image (zImage.treeboot), we use the "VxWorks bootrom" bootloader which download the image via tftp.
> That works well except the fact that in the LSP, linux tried to get a board info structure in flash memory at an address where we have nothing. So we replace this behavior in "embed_config.c" with the following lines (note: I had to re-code the strcpy although there is the #include<string.h> because it cannot find the reference at the link level... why???):
> 

I would recomend using u-boot for a boot rom. It was a god send to us in 
getting our MPC850 board up and going the first time. On our 405EP board 
we did have to do some slight hacking but nothing really major.


> /* We use VxWorks bootrom, so we have to create ourselves the boot info structure */

<snip>


> Jérémie        \\ (°.°) //~ ~ ~ HELP ~ ~ ~ \\ (°.°) //
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 

-- Conn

*****************************************************************
Blessed be the heretic, for he causes some to think and unites
the rest against him.
*****************************************************************

Conn Clark
Engineering Assistant                clark@esteem.com
Electronic Systems Technology Inc.        www.esteem.com

Stock Ticker Symbol                ELST
