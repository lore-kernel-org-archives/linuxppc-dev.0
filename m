Return-Path: <linuxppcleo@gmail.com>
Message-ID: <a0bc9bf80608030917y7fde2b75n6719dc675cad8cfe@mail.gmail.com>
Date: Fri, 4 Aug 2006 00:17:53 +0800
From: "Li Yang" <LeoLi@freescale.com>
Sender: linuxppcleo@gmail.com
To: "Matthew McClintock" <msm@freescale.com>
Subject: Re: [RFC] New target 'cuImage' - compatibility uImage
In-Reply-To: <1154620934.5094.12.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <20060802223302.9667135360F@atlas.denx.de>
	<1154618945.5094.6.camel@localhost>
	<a0bc9bf80608030856p45870487of2646c4f9393869b@mail.gmail.com>
	<1154620934.5094.12.camel@localhost>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 8/4/06, Matthew McClintock <msm@freescale.com> wrote:
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

Though it will need more space, the increase won't be too much as
wrapper and FDT should be very small.  The benefit is that kernel can
be extract directly to it's destination(address 0), rather than
extract to another place and then move it there.  A classical
time/space tradeoff.

>
> -Matthew
