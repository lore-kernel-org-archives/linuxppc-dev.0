Subject: Re: pmdisk infrastructure
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Guido Guenther <agx@sigxcpu.org>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20040722142740.GA3003@bogon.ms20.nix>
References: <20040712065951.GB9536@bogon.ms20.nix>
	 <1090506345.2003.31.camel@gaston>  <20040722142740.GA3003@bogon.ms20.nix>
Content-Type: text/plain
Message-Id: <1090510226.2002.33.camel@gaston>
Mime-Version: 1.0
Date: Thu, 22 Jul 2004 11:30:27 -0400
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 2004-07-22 at 10:27, Guido Guenther wrote:
> On Thu, Jul 22, 2004 at 10:25:46AM -0400, Benjamin Herrenschmidt wrote:
> > On Mon, 2004-07-12 at 02:59, Guido Guenther wrote:
> > > Hi,
> > > the attached patch adds the infrastructure needed for pmdisk on ppc.
> > > Most of it was done by Benjamin with some modifications by me. These are
> > > the parts that don't affect anything else. The full patch is here:
> > >  http://honk.physik.uni-konstanz.de/~agx/linux-ppc/kernel/pmdisk-2.6.7.diff
> > > Patch is against 2.6.7 but applies without problems against 2.6.7-bk20.
> For me it does and according to the server logs for several other people
> too. There's also
> http://honk.physik.uni-konstanz.de/~agx/linux-ppc/kernel/pmdisk-2.6.8-rc2.diff
> now. What are you seeing 404?

DNS on crack here at OLS. I'm in the process of merging all of that with
Pat & Pavel rework of swsusp, hopefully it will be all up by the end of
the week.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
