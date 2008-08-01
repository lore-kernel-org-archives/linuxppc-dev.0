Return-Path: <dgibson@ozlabs.org>
Date: Fri, 1 Aug 2008 16:22:59 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Board level compatibility matching
Message-ID: <20080801062259.GL5008@yookeroo.seuss>
References: <fa686aa40807311319k44d270b0t4fa9cb0e6523339@mail.gmail.com>
	<9e4733910807311349l5770a17ib2ab2535bcd2868a@mail.gmail.com>
	<20080731205251.GB29834@secretlab.ca>
	<9e4733910807311358k54b5c088l1023d354fd0ad28e@mail.gmail.com>
	<20080801024729.GA5008@yookeroo.seuss>
	<9e4733910807312006l8e83d27qe1b5ca5f50b89e39@mail.gmail.com>
	<20080801033009.GG5008@yookeroo.seuss>
	<9e4733910807312100j6a8d1974k34054c2d69f417f4@mail.gmail.com>
	<20080801042505.GK5008@yookeroo.seuss>
	<9e4733910807312137w2dc9e73l39d4d99bd0cfe0c6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9e4733910807312137w2dc9e73l39d4d99bd0cfe0c6@mail.gmail.com>
Cc: devicetree-discuss@ozlabs.org, linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Aug 01, 2008 at 12:37:25AM -0400, Jon Smirl wrote:
> On 8/1/08, David Gibson <david@gibson.dropbear.id.au> wrote:
> > On Fri, Aug 01, 2008 at 12:00:01AM -0400, Jon Smirl wrote:
> >  > On 7/31/08, David Gibson <david@gibson.dropbear.id.au> wrote:
> >  > > On Thu, Jul 31, 2008 at 11:06:20PM -0400, Jon Smirl wrote:
> >  > >  > On 7/31/08, David Gibson <david@gibson.dropbear.id.au> wrote:
[snip]
> >  > Why does the fake fabric device need to be in the device tree? Can't
> >  > we just dynamically create it as part of the boot process?
> >
> >
> > Um.. yes.. that would be exactly what instantiating it from the
> >  platform code does.
> 
> Platform devices are missing the compatible chain process. If we do
> this with platform drivers the boot code creates a 'fabric' device
> then I'll have to ensure that my board-fabric driver gets probed
> before default-fabric because they both want to bind to the fabric
> device.

If you need a board-specific fabric driver, the board platform code
shouldn't be instantiating the generic fabric driver.  Given the board
specific driver a different name...

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
