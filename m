Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 35B91474C8
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Dec 2008 05:24:48 +1100 (EST)
Message-Id: <C1D0D20C-F1A5-4D73-BB69-D18F1A1A8E83@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20081205154807.GA23256@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] powerpc/83xx: Fix sparse warnings in board files
Date: Tue, 16 Dec 2008 12:24:43 -0600
References: <20081205154807.GA23256@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 5, 2008, at 9:48 AM, Anton Vorontsov wrote:

> This patch fixes following sparse warnings:
>
>  CHECK   83xx/usb.c
> 83xx/usb.c:205:5: warning: symbol 'mpc837x_usb_cfg' was not  
> declared. Should it be static?
>  CHECK   83xx/mpc831x_rdb.c
> 83xx/mpc831x_rdb.c:45:13: warning: symbol 'mpc831x_rdb_init_IRQ' was  
> not declared. Should it be static?
>  CHECK   83xx/mpc832x_rdb.c
> 83xx/mpc832x_rdb.c:133:13: warning: symbol 'mpc832x_rdb_init_IRQ'  
> was not declared. Should it be static?
>  CHECK   83xx/mpc832x_mds.c
> 83xx/mpc832x_mds.c:68:12: warning: Using plain integer as NULL pointer
> 83xx/mpc832x_mds.c:72:13: warning: incorrect type in assignment  
> (different address spaces)
> 83xx/mpc832x_mds.c:72:13:    expected unsigned char [usertype]  
> *static [toplevel] bcsr_regs
> 83xx/mpc832x_mds.c:72:13:    got void [noderef] <asn:2>*
> 83xx/mpc832x_mds.c:99:11: warning: incorrect type in argument 1  
> (different address spaces)
> 83xx/mpc832x_mds.c:99:11:    expected void volatile [noderef] <asn: 
> 2>*addr
> 83xx/mpc832x_mds.c:99:11:    got unsigned char [usertype] *static  
> [toplevel] bcsr_regs
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---


applied to next

- k
