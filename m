Return-Path: <dgibson@ozlabs.org>
Date: Thu, 27 Mar 2008 09:51:28 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RESEND][POWERPC] mpc5200: Amalgamated dts fixes and updates
Message-ID: <20080326225128.GB5777@localhost.localdomain>
References: <47E2723D.1090101@grandegger.com> <47E281B6.20702@denx.de>
	<fa686aa40803201650t289cd800gfda389b192c1834c@mail.gmail.com>
	<47E2FC3E.1020705@semihalf.com>
	<fa686aa40803201720l3e42c983se121ebc257c89912@mail.gmail.com>
	<20080321235633.GB345@frozen.semihalf.com>
	<fa686aa40803212014ne560615sfcdef542d59eb6cb@mail.gmail.com>
	<20080326194526.GA17424@frozen.semihalf.com>
	<47EAB9CC.7060002@genesi-usa.com>
	<fa686aa40803261416s38164c98ua774731eadc1f85f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fa686aa40803261416s38164c98ua774731eadc1f85f@mail.gmail.com>
Cc: Anatolij Gustschin <agust@denx.de>, Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 26, 2008 at 03:16:47PM -0600, Grant Likely wrote:
> On Wed, Mar 26, 2008 at 3:02 PM, Matt Sealey <matt@genesi-usa.com> wrote:
> > Bartlomiej Sieka wrote:
> >  > +
> >  > +                     phy0:ethernet-phy@0 {
> >  > +                             device_type = "ethernet-phy";@0"
> >  > +                             reg = <0>;
> >  > +                     };
> >
> >  What's the parsing of this pan out to? What does it mean?
> >
> >  Having colons in device names is totally contrary to OF device naming
> >  spec. Does the part after the colon have a special meaning to the DTC?
> 
> "phy0:" is a label used by dtc.
> "ethernet-phy@0" is the node name.

I would suggest a space after the colon though, to make this clearer.
That's the style I've been using in all my dts files.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
