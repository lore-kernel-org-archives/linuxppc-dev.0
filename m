Return-Path: <dgibson@ozlabs.org>
Date: Wed, 29 Oct 2008 10:37:32 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Konstantinos Margaritis <markos@codex.gr>
Subject: Re: GPIO - marking individual pins (not) available in device tree
Message-ID: <20081028233732.GB9124@yookeroo.seuss>
References: <7b6eafc46f644dea59fbf0af17dbc005@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7b6eafc46f644dea59fbf0af17dbc005@localhost>
Cc: Mitch Bradley <wmb@firmworks.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	devicetree-discuss list <devicetree-discuss@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Oct 28, 2008 at 02:31:29PM +0100, Konstantinos Margaritis wrote:
> 
> Pardon my intrusion in the conversation, but I just couldn't not comment on
> this:
> 
> On Tue, 28 Oct 2008 12:50:03 +1100, David Gibson
> <david@gibson.dropbear.id.au> wrote:
> >> So now my qualm is back to the beginning of the discussion. How do
> >> we encode the purpose of those pins reliably and within some
> >> standard framework, without getting *driver* specific?
> >
> > Um.. I fail to see how the purpose of a pin can be not driver
> > specific.
> 
> GPIO stands for _General_ Purpose IO. The driver should just expose that
> info to user space and it should be up to the userspace application to
> decide what to do with that. The programmer should require absolutely
> no other intervention to the driver whatsoever.

Yes, which is exactly why the purpose of the pin is driver specific.
That's the driver for the user of the pin, not the gpio controller.
In some cases that's another kernel driver, where some device needs
gpio access, in your case it's the userspace application.  But in
either case it's this driver that must know what gpio line to use, and
how to use it.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
