Return-Path: <mgreer@mvista.com>
Date: Thu, 3 Aug 2006 12:37:49 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Matthew McClintock <msm@freescale.com>
Subject: Re: [RFC] New target 'cuImage' - compatibility uImage
Message-ID: <20060803193749.GE25251@mag.az.mvista.com>
References: <20060802223302.9667135360F@atlas.denx.de>
	<1154618945.5094.6.camel@localhost>
	<a0bc9bf80608030856p45870487of2646c4f9393869b@mail.gmail.com>
	<1154620934.5094.12.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1154620934.5094.12.camel@localhost>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Aug 03, 2006 at 11:02:14AM -0500, Matthew McClintock wrote:
> On Thu, 2006-08-03 at 23:56 +0800, Li Yang wrote:
> > 
> > If U-boot supports uncompressed kernel image in uImage, I think it
> > will be better to use this scheme:
> > 
> > u-boot header + wrapper + FDT + compressed kernel image
> > 
> > As kernel image will be uncompressed to its loading address directly.
> > While in your proposal, it needs to be moved one more time.
> > 
> 
> This is an option. But, I do not see a reason why you would not still
> opt to compress everything. Especially since it is already working.
> Comments anyone?

Yes...sort of.  I believe that one of the goals is to be able to tack
an fdt onto a zImage/uImage/whatever long after that image has been
built.  That would be simpler if the fdt wasn't compressed. 

A proper tool can handle this, of course, but it would be simpler and
not a huge waste of space to keep the fdt uncompressed.

But, as long as we have tools to view and modify the fdt that in the
clump of bits, I don't really care that much.

Mark
