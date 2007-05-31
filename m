Return-Path: <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH 3/3] powerpc: Update holly to use new dts wrapping feature
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: "Mark A. Greer" <mgreer@mvista.com>
In-Reply-To: <20070531195615.GC3818@mag.az.mvista.com>
References: <20070531195136.GA3699@mag.az.mvista.com>
	<20070531195615.GC3818@mag.az.mvista.com>
Content-Type: text/plain
Date: Thu, 31 May 2007 16:25:39 -0500
Message-Id: <1180646739.3360.92.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>, David Gibson <dgibson@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-05-31 at 12:56 -0700, Mark A. Greer wrote:
> The holly support currently has separate rules to wrap its device tree
> with its zImage.  This can now be done automatically without the extra
> rules so update holly support to use the automatic feature.

Oh good.  I like that idea already.

> Signed-off-by: Mark A. Greer <mgreer@mista.com>
> 
> ---
> 
> Josh, please take a look at this patch and if you approve, give me an
> Acked-by: line (thanks).  

I'll test this on Monday first thing.

> Note that 'zImage.holly-elf' was changed to
> 'zImage.holly'.

That part is fine either way.

josh
