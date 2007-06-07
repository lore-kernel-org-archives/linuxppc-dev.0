Return-Path: <SRS0+8f2be1f524bb961c24bd+1383+infradead.org+dwmw2@canuck.srs.infradead.org>
Subject: Re: [PATCH] powerpc: Create "rom" (MTD) device prpmc2800
From: David Woodhouse <dwmw2@infradead.org>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
In-Reply-To: <4666AB89.1010206@ru.mvista.com>
References: <20070601232022.GA21237@mag.az.mvista.com>
	<20070604205646.GD10612@mag.az.mvista.com>
	<4665C8F4.2090502@ru.mvista.com>
	<20070605211114.GA17131@mag.az.mvista.com>
	<4666AB89.1010206@ru.mvista.com>
Content-Type: text/plain
Date: Thu, 07 Jun 2007 16:08:19 +0100
Message-Id: <1181228899.2785.62.camel@pmac.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>, linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-06-06 at 16:41 +0400, Sergei Shtylyov wrote:
> >       if (*part++ & 1) /* bit 0 set signifies read only partition */
> >               (*parts)[i].mask_flags = MTD_WRITEABLE;
> 
> > Doesn't that make it RW if bit 0 is set? 

What do you get if you mask out the WRITEABLE flag?

-- 
dwmw2
