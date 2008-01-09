Return-Path: <sven@powerlinux.fr>
Received: from archon.plz.fr (archon.plz.fr [194.50.78.210])
	by ozlabs.org (Postfix) with ESMTP id 2E6DFDDE0F
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 04:22:09 +1100 (EST)
Date: Wed, 9 Jan 2008 18:22:08 +0100
From: Sven Luther <sven@genesi-usa.com>
To: Matt Sealey <matt@genesi-usa.com>
Subject: Re: add phy-handle property for fec_mpc52xx
Message-ID: <20080109172208.GD6789@powerlinux.fr>
References: <20080109140608.GA15673@aepfle.de> <4784E78C.40904@genesi-usa.com>
	<20080109153511.GA5086@powerlinux.fr>
	<4784F695.7050507@genesi-usa.com>
	<20080109162923.GA6290@powerlinux.fr>
	<4784F803.9030003@genesi-usa.com>
	<20080109170540.GA6789@powerlinux.fr>
	<478501C0.9040905@genesi-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <478501C0.9040905@genesi-usa.com>
Cc: Sven Luther <sven@genesi-usa.com>, Olaf Hering <olaf@aepfle.de>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 09, 2008 at 05:17:52PM +0000, Matt Sealey wrote:
> 
> Sven Luther wrote:
> >On Wed, Jan 09, 2008 at 04:36:19PM +0000, Matt Sealey wrote:
> >>The link that Olaf presented, www.powerdeveloper.org/asset/by-id/46 *is*
> >>the upstream support for now. What his patch does is say, the upstream
> >>support exists, but we don't like it, so we will supplement the patch..
> >
> >Matt, your work on efika.forth is laudable, and it is nice that you took
> >the time to support it.
> >
> >*BUT* it is not acceptable for a distribution, or for someone who will
> >have to do user support, to have to launch a second binary before
> >launching the kernel. Especially when netbooting for example.
> 
> Then I think you are all missing the fact that I said there *IS A REALLY
> CUTE WAY OF INSTALLING IT ONCE* by uploading it into nvramrc, it will not
> be a runnable script, but executed on boot, because it'll be flashed into
> nvramrc.
> 
> However I don't have the time to go into making this app, creating the
> tools to munge efika.forth into a correct more uploadable format, and
> creating the install tool. I barely have enough time to track this list
> and make sure any drivers requiring firmware tree changes are taken care
> of (I definitely lost the plot with the USB one, I haven't even checked
> it even though I was asked to 2 weeks ago..)
> 
> Unfortunately one guy who already has a significant amount of work to do
> all day, who is not the responsible person for firmware issues, and is
> not being assisted by anyone in the community either generated and
> maintained by Genesi or existing around Linux, poses some serious problems
> with timeliness of updates.
> 
> If anyone wants to stop patching Linux and instead make efika.forth easier
> to use, feel free, REALLY. Sven, are you volunteering for this REALLY
> tiny task? It will probably take all of a day for a couple of guys to
> work up the tools to do it based on very simple instructions and data
> provided.. the work is probably worth the price of a pizza, so no
> contracts are going to be worked out for it.

Just fix it conditionally in linux, like it is being proposed, and
everyone is happy :)

Friendly,

Sven Luther
