Return-Path: <jonsmirl@gmail.com>
Message-ID: <9e4733910711181349q1f840bc2w8d30bb33d2a353ce@mail.gmail.com>
Date: Sun, 18 Nov 2007 16:49:33 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Segher Boessenkool" <segher@kernel.crashing.org>
Subject: Re: Revisited, audio codec device tree entries.
In-Reply-To: <0fd3304ee694b2dc6a8f3055c08dc015@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910711181010q50c08d2ek8413af74d58cf0ce@mail.gmail.com>
	<0fd3304ee694b2dc6a8f3055c08dc015@kernel.crashing.org>
Cc: PowerPC dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 11/18/07, Segher Boessenkool <segher@kernel.crashing.org> wrote:
> > David Gibson
> > made a proposal that a fabric node wrap the codec node. That doesn't
> > work very well with the i2c bus where the bus code is walking down the
> > nodes and triggering the instantiation of the i2c drivers.
>
> Yeah, doesn't work at all.
>
> > But what about putting the fabric node inside the codec node?
>
> _Which_ codec node?  Having more than one isn't uncommon at all.

In all of them. Fabric can probably be split into pieces that
corresponds to the codec.

> There is no way you can describe this fabric stuff in a generic way in
> the device tree.  Just hardcode it in your platform support code; if
> the platform code supports several variant boards, _it_ can probe that
> from the device tree (in whatever way works for that platform).

The codec-fabric node was just being used to trigger the loading of
the platform specific driver.

>
>
> Segher
>
>


-- 
Jon Smirl
jonsmirl@gmail.com
