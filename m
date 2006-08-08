Return-Path: <mgreer@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id C26C9679E0
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Aug 2006 10:12:17 +1000 (EST)
Date: Mon, 7 Aug 2006 17:16:09 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Hollis Blanchard <hollisb@us.ibm.com>
Subject: Re: [PATCH 1/6] bootwrapper: arch/powerpc/boot code reorg
Message-ID: <20060808001609.GD4582@mag.az.mvista.com>
References: <20060719230014.GB3887@mag.az.mvista.com>
	<1154910111.27074.87.camel@diesel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1154910111.27074.87.camel@diesel>
Cc: linuxppc-dev@ozlabs.org,
	"xen-ppc-devel@lists.xensource.com" <xen-ppc-devel@lists.xensource.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Aug 06, 2006 at 07:21:51PM -0500, Hollis Blanchard wrote:
> On Wed, 2006-07-19 at 16:00 -0700, an unknown sender wrote:
> > diff --git a/arch/powerpc/boot/types.h b/arch/powerpc/boot/types.h
> > new file mode 100644
> > index 0000000..2a2fa2b
> > --- /dev/null
> > +++ b/arch/powerpc/boot/types.h
> > @@ -0,0 +1,29 @@
> > +#ifndef _TYPES_H_
> > +#define _TYPES_H_
> > +
> > +#define        COMMAND_LINE_SIZE       512
> > +#define        MAX_PATH_LEN            256
> > +#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
> > +
> > +typedef unsigned char          u8;
> > +typedef unsigned short         u16;
> > +typedef unsigned int           u32;
> > +#ifdef __powerpc64__
> > +typedef unsigned long          u64;
> > +#else
> > +typedef unsigned long long     u64;
> > +#endif 
> 
> As long as we're adding new typedefs, could we please use the stdint.h
> ones (e.g. uint32_t)? For Xen, I need to do flat tree munging in
> userspace, so using real types would help with code reuse.

Sure, I can do that unless someone objects.

Mark
