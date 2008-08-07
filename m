Return-Path: <stuart.yoder@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [RFC/PATCH 2/3] of: add of_lookup_stdout() utility function
Date: Thu, 7 Aug 2008 10:28:35 -0700
Message-ID: <9696D7A991D0824DBA8DFAC74A9C5FA3043BC7D7@az33exm25.fsl.freescale.net>
In-Reply-To: <20080807061254.GB12571@yookeroo.seuss>
References: <20080806055214.30717.86092.stgit@trillian.secretlab.ca><20080806060239.30717.79273.stgit@trillian.secretlab.ca><ed82fe3e0808060946v39992095pfb6b85726b7d307d@mail.gmail.com>
	<20080807061254.GB12571@yookeroo.seuss>
From: "Yoder Stuart" <stuart.yoder@freescale.com>
To: "David Gibson" <david@gibson.dropbear.id.au>,
	"TABI TIMUR" <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org, paulus@samba.org,
	miltonm@bga.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=20

> -----Original Message-----
> From: linuxppc-dev-bounces+b08248=3Dfreescale.com@ozlabs.org=20
> [mailto:linuxppc-dev-bounces+b08248=3Dfreescale.com@ozlabs.org]=20
> On Behalf Of David Gibson
> Sent: Thursday, August 07, 2008 1:13 AM
> To: Tabi Timur
> Cc: linuxppc-dev@ozlabs.org; paulus@samba.org; miltonm@bga.com
> Subject: Re: [RFC/PATCH 2/3] of: add of_lookup_stdout()=20
> utility function
>=20
> On Wed, Aug 06, 2008 at 11:46:47AM -0500, Timur Tabi wrote:
> > On Wed, Aug 6, 2008 at 1:02 AM, Grant Likely=20
> <grant.likely@secretlab.ca> wrote:
> > > From: Grant Likely <grant.likely@secretlab.ca>
> > >
> > > of_lookup_stdout() is useful for figuring out what device=20
> to use as output
> > > for early boot progress messages.  It returns the node=20
> pointed to by the
> > > linux,stdout-path property in the chosen node.
> >=20
> > I thought linux,stdout-path is deprecated are we're supposed to be
> > using the aliases node instead?
>=20
> During the ePAPR process this idea came up - standardising a 'stdout'
> alias that would replace linux,stdout-path in chosen.  However that
> was done in ignorance of the history of the linux,stdout-path property
> and its connection to the stdout ihandle in chosen.  In any case, the
> proposed 'stdout' alias didn't make the final cut for ePAPR, so how to
> address this for flat-tree systems is still an open question.

In the ePAPR discussion I think we generally agreed that
an alias was better than a property under /chosen.  There
were 2 things that caused us to delete the /aliases/stdout.

One was discussions around whether we needed to support
multiple consoles somehow.

The second was the idea that we may need a /aliases/stdin as well.
You could conceptually have stdout be a monitor and a stdin
be a keyboard.

Stuart
