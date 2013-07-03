Return-Path: <B07421@freescale.com>
Date: Wed, 3 Jul 2013 11:41:31 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/2] DMA: Freescale: update driver to support 8-channel
 DMA engine
To: Hongbo Zhang <hongbo.zhang@freescale.com>
In-Reply-To: <51D39EE0.1040901@freescale.com> (from
 hongbo.zhang@freescale.com on Tue Jul  2 22:47:44 2013)
Message-ID: <1372869691.8183.130@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: vinod.koul@intel.com, devicetree-discuss@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, vakul@freescale.com, djbw@fb.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/02/2013 10:47:44 PM, Hongbo Zhang wrote:
> On 07/03/2013 07:13 AM, Scott Wood wrote:
>> Wait a second -- how are we even getting into this code on these new =20
>> DMA controllers?  All 85xx-family DMA controllers use =20
>> fsldma_chan_irq directly.
>>=20
> Right, we are using fsldma_chan_irq, this code never run.
> I just see there is such code for elo/eloplus DMA controllers, so I =20
> update it for the new 8-channel DMA.

That code is used for elo (e.g. mpc83xx DMA), but not eloplus.

-Scott=
