Return-Path: <B07421@freescale.com>
Date: Mon, 15 Jul 2013 12:12:17 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH V2 1/2] DMA: Freescale: Add new 8-channel DMA engine
 device tree nodes
To: Kumar Gala <galak@kernel.crashing.org>
References: <1373005626-20726-1-git-send-email-hongbo.zhang@freescale.com>
 <1373005626-20726-2-git-send-email-hongbo.zhang@freescale.com>
 <6482CAC0-9C6A-4A1E-B158-28D2E1BB2CCE@kernel.crashing.org>
In-Reply-To: <6482CAC0-9C6A-4A1E-B158-28D2E1BB2CCE@kernel.crashing.org>
 (from galak@kernel.crashing.org on Mon Jul 15 08:35:07 2013)
Message-ID: <1373908337.8183.301@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: "<hongbo.zhang@freescale.com>" <hongbo.zhang@freescale.com>,
 devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 vakul@freescale.com, vinod.koul@intel.com, djbw@fb.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/15/2013 08:35:07 AM, Kumar Gala wrote:
>=20
> On Jul 5, 2013, at 1:27 AM, <hongbo.zhang@freescale.com> =20
> <hongbo.zhang@freescale.com> wrote:
>=20
> > +dma0: dma@100300 {
> > +	#address-cells =3D <1>;
> > +	#size-cells =3D <1>;
> > +	compatible =3D "fsl,elo3-dma";
>=20
> why does this require a new compatible?

The binding has changed -- there is now a second reg entry.

-Scott=
