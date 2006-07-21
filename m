Return-Path: <Tony.Li@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [Linux-ATM-General] mpc8360sar
Date: Fri, 21 Jul 2006 10:36:47 +0800
Message-ID: <995B09A8299C2C44B59866F6391D26350587BD@zch01exm21.fsl.freescale.net>
In-Reply-To: <44BFABFD.1070904@cambridgebroadband.com>
From: "Li Tony-r64360" <Tony.Li@freescale.com>
To: "Alex Zeffertt" <ajz@cambridgebroadband.com>,
	"Kumar Gala" <galak@kernel.crashing.org>,
	"Chu hanjin-r52514" <Hanjin.Chu@freescale.com>
Cc: linuxppc-dev@ozlabs.org, linux-atm-general@lists.sourceforge.net,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 Alex, we are working on the 8360 upstream. As the similarity between
832x and 8360, if the 8360 has benn accepted, it would be easy for 832x
upstream.
We have submit the 8360 patch to the opensource. But we are waiting it
to be accepted.

BTW,  the new version QOC3-ATM card will adopt. The QOC3-ATM card code
need some modification.=20
I send the new code to you if it done. Ok ?
Tony

> -----Original Message-----
> From: Alex Zeffertt [mailto:ajz@cambridgebroadband.com]=20
> Sent: Friday, July 21, 2006 12:15 AM
> To: Kumar Gala
> Cc: Li Tony-r64360; linux-atm-general@lists.sourceforge.net;=20
> linuxppc-embedded@ozlabs.org
> Subject: Re: [Linux-ATM-General] mpc8360sar
>=20
> Kumar Gala wrote:
> >=20
> > On Jul 20, 2006, at 8:33 AM, Alex Zeffertt wrote:
> >=20
> >>
> >>> Any reason we dont try to get your work up stream into=20
> the mainline=20
> >>> kernel?
> >>> - kumar
> >>
> >> I'd like to see it upstreamed - the more people who use it=20
> the more=20
> >> help I get!
> >>
> >> However, mpc8360sar is built on Freescale's BSP which adds basic=20
> >> support for the board, the MPC832xE-MDS, to the stock=20
> linux kernel. =20
> >> This support consists of the following patches:
> >>
> >> Patch0          : patch-2.6.11.bz2
> >> Patch1          : linux-2.6.11-mpc8349e-general-20060414.patch
> >> Patch2          : linux-2.6.11-mpc8349e-pci-3.patch
> >> Patch3          : linux-2.6.11-mpc8349e-pci-agent.patch
> >> Patch4          : linux-2.6.11-mpc8349e-watchdog.patch
> >> Patch5          : linux-2.6.11-mpc83xx-sec2.patch
> >> Patch6          : mpc832x-sec2v15-config-1.patch
> >> Patch7          : linux-2.6.11-mpc8349e-usb-gadget.patch
> >> Patch8          : linux-2.6.11-mpc8349e-usb-host.patch
> >> Patch9          : linux-2.6.11-mpc8360-general-1.patch
> >> Patch10         : linux-2.6.11-mpc8360-pci-agent.patch
> >> Patch11         : linux-2.6.11-mpc832x-basic-4.patch
> >> Patch12         : linux-2.6.11-mpc832x-pci-agent.patch
> >> Patch13         : linux-2.6.11-mpc832x-spi-1.patch
> >> Patch14         : linux-2.6.11-mpc832x-BIT.patch
> >> Patch15         : linux-2.6.11-mpc83xx-ct-1.patch
> >> Patch16         : linux-2.6.11-mpc832x-usb-gadget.patch
> >> Patch17         : linux-2.6.11-mpc832x-atm-1.patch
> >>
> >> I guess there's no point upstreaming mpc8360sar until=20
> freescale have=20
> >> upstreamed these patches (and ported them to the current kernel).
> >=20
> > True, a large number of these patches are upstream, and if I had=20
> > access to MPC836x or MPC832x HW I'd work on getting the others that=20
> > are reasonable.
> >=20
> >> Alex
> >>
> >> PS It's probable that mpc8360sar actually only requires a=20
> handful of=20
> >> the above patches to be applied.
> >=20
> > Agreed.
> >=20
> > - kumar
>=20
>=20
> Tony, can you let me know when CONFIG_MPC832XE_MDS support is=20
> upstreamed to a kernel.org kernel.  I'll then try to get the=20
> mpc8360sar working with this kernel and then upstream it.
>=20
> Alex
>=20
> PS I'm not entirely sure how "upstreaming" is done.
>=20
