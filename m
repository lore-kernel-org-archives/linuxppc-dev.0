Return-Path: <benh@kernel.crashing.org>
Subject: Re: Flattened device tree for Pegasos
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Mark A. Greer" <mgreer@mvista.com>
In-Reply-To: <20060213180320.GB4530@mag.az.mvista.com>
References: <Pine.LNX.4.44.0602101844150.31619-100000@gate.crashing.org>
	<1139782333.5247.44.camel@localhost.localdomain>
	<20060213180320.GB4530@mag.az.mvista.com>
Content-Type: text/plain
Date: Tue, 14 Feb 2006 09:27:08 +1100
Message-Id: <1139869628.5237.18.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2006-02-13 at 11:03 -0700, Mark A. Greer wrote:
> On Mon, Feb 13, 2006 at 09:12:12AM +1100, Benjamin Herrenschmidt wrote:
> > On Fri, 2006-02-10 at 18:46 -0600, Kumar Gala wrote:
> > > On Fri, 10 Feb 2006, Mark A. Greer wrote:
> > > 
> > > > If anyone happens to have a Pegasos running the merged powerpc kernel
> > > > handy, I would greatly appreciate a dump of flattened device tree that
> > > > it uses.
> > > 
> > > We really need to put OF tree's somewhere that people can get to, maybe 
> > > penguinppc.org.
> > > 
> > > Ben, Segher, Paul:
> > > 
> > > You guys have either access to HW or tree dump's already.  Would you be 
> > > willing to share them?
> > 
> > There is an unresolved issue about what is the (c) for those
> > device-tree, especially since the Apple ones may contain driver blobs...
> 
> Is that still an issue for the flattened dev tree version(s)?
> 
> I'd still like a flattened dev tree for the pegasos if that's legal. :)

The issue is the (c) of Apple trees mostly... that is, I don't think I
can post my collection of Apple device-tree snapshots online.

Ben.
