Date: Thu, 22 Jan 2004 09:59:44 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Wolfgang Denk <wd@denx.de>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: linux-2.4-mpc5xxx repository updates
Message-ID: <20040122165944.GH15271@stop.crashing.org>
References: <20040121203242.65077C11FC@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040121203242.65077C11FC@atlas.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Jan 21, 2004 at 09:32:37PM +0100, Wolfgang Denk wrote:

> In message <20040121170151.GS13454@stop.crashing.org> you wrote:
> >
> > I know it's been a while, and the general consensious (as I read it at
> > least) was that this code is still too ugly to get to kernel.org, but
> > regardless, I've finally gotten around to updating this repository
> > again.  And this time I didn't restart the repository from scratch, I
> > just pushed.  The only change is:
> > - From Dale Farnsworth, fix the IceCube support
>
> OK, here are some more patches:
[snip]
> patch.i2c_speed:
>
> 	* Make I2C speed on MPC5200 configurable by module parameter

I've changed this slightly so that we export __res on || CONFIG_UBOOT,
not CONFIG_6xx (EXPORT_SYMBOL() of an undefined symbol doesn't work,
iirc).

I'll be pushing 'em all out within the hour.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
