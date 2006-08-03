Return-Path: <msm@freescale.com>
Subject: Re: [RFC] New target 'cuImage' - compatibility uImage
From: Matthew McClintock <msm@freescale.com>
To: Milton Miller <miltonm@bga.com>
In-Reply-To: <3115462902741b71efb4.2044897763.miltonm@bga.com>
References: <3115462902741b71efb4.2044897763.miltonm@bga.com>
Content-Type: text/plain
Date: Thu, 03 Aug 2006 13:53:28 -0500
Message-Id: <1154631208.5094.25.camel@localhost>
Mime-Version: 1.0
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-08-03 at 13:17 -0500, Milton Miller wrote:
> On Thu Aug  3 2006 10:30:13 AM CDT, Matthew McClintock wrote:
> > On Thu, 2006-08-03 at 04:47 -0700, Li Yang-r58472 wrote:
> > > If my understanding to Matt's idea is correct, it will be a good way,
> > > IMHO.  How about use the naming of uwImage(U-boot Wrapped Image) or
> > > utImage(u-boot device-Tree Image). 
> > 
> > I am completely open to a better name. Anyone else care to share their
> > opinion?
> 
> Do newer versions of uboot support device tree kernels directly?  If not, then
> I would say make this uimage.  Otherwise,  I would say uzImage unless we
> decide to call the wrapper that adds the tree something else, like uImage.dt.
> 
> Or maybe its uImage and config vars say which it is.
> 

There is an unofficial way to boot device tree kernels directly from
U-Boot. There was an older method that has been in U-Boot a long time
(and still is), however I just submitted a series of patches which
updates that method.

As far as I know the new method is liked better by Wolfgang, so maybe he
will start accepted board patches based on my work? Either way, for
boards with newer U-Boots (at some point) will not boot using this
method.

Wolfgang, care to comment?

-Matthew
