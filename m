Return-Path: <jdl@jdl.com>
To: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH] dtc: parse NOP in dtb input 
In-Reply-To: Your message of "Sat, 09 Jun 2007 23:21:31 CDT."
	<311814492916b8b45674.846930886.miltonm@bga.com>
References: <311814492916b8b45674.846930886.miltonm@bga.com> 
Date: Mon, 11 Jun 2007 08:41:01 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1Hxk8j-00030q-J7@jdl.com>
Cc: linuxppc-dev@ozlabs.org, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day Milton Miller mumbled:
> Version 16 and later of the flat device tree format allow NOPs
> to be placed in the tree.  When processing dtb input, dtc must
> recognise them.
> 
> Previously it would produce the error message
> FATAL ERROR: Invalid opcode word 00000004 in device tree blob
> 
> Signed-off-by: Milton Miller <miltonm@bga.com>

Applied.

Thanks,
jdl
