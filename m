Return-Path: <benh@kernel.crashing.org>
Subject: Re: Video Card to Lite5200
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20060701091507.EA1F4352681@atlas.denx.de>
References: <20060701091507.EA1F4352681@atlas.denx.de>
Content-Type: text/plain
Date: Sat, 01 Jul 2006 19:29:39 +1000
Message-Id: <1151746179.19419.0.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	roger blofeld <blofeldus@yahoo.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2006-07-01 at 11:15 +0200, Wolfgang Denk wrote:
> In message <1151709367.27137.4.camel@localhost.localdomain> you wrote:
> >
> > > I don;t know - the patches were submitted to this list  a  long  time
> > > ago; we added them to our repository without any additional problems;
> > > see http://www.denx.de/cgi-bin/gitweb.cgi?p=linux-2.6-denx.git
> > 
> > Any reason why you keep that repository instead of submiting the patches
> > for proper upstream inclusion or to linuxppc-dev at least ?
> 
> We submit patches every now and then, as time permits.  My  intention
> is to keep the differences between our tree and kernel.org minimal.
> 
> But you know how this goes: just adding support for a new board means
> sending patches to the linuxppc_dev, mtd, i2c, usb,  lm_sensors,  ...
> mailing  lists. Then you have to wait some time, then you resend. and
> you have to keep track of all these things.  And  the  board  support
> will  not  work  before the last piece of the puzze has been accepted
> and merged and pushed upstream. All this takes a lot  of  effort  and
> even  more  calendar time. We need a way to provide a solution to our
> customers fast - that's why we maintain our own development branch.
> 
> I'd be happy if you could recommend a better approach to handle this.

Oh, it's fine to maintain a dev. branch, but I haven't seen you submit
stuff to linuxppc-dev for some time so I wanted to make sure you were
still on track :)

Ben.
