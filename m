Return-Path: <B07421@freescale.com>
Date: Wed, 3 Jul 2013 14:02:08 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/2] DMA: Freescale: Add new 8-channel DMA engine device
 tree nodes
To: Hongbo Zhang <hongbo.zhang@freescale.com>
References: <1372650378-2936-1-git-send-email-hongbo.zhang@freescale.com>
 <51D3A030.4020608@freescale.com> <51D3D76B.5040306@freescale.com>
In-Reply-To: <51D3D76B.5040306@freescale.com> (from
 hongbo.zhang@freescale.com on Wed Jul  3 02:48:59 2013)
Message-ID: <1372878128.8183.143@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Hongbo Zhang <hongbo.zhang@freescale.com>,
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

On 07/03/2013 02:48:59 AM, Hongbo Zhang wrote:
> On 07/03/2013 11:53 AM, Hongbo Zhang wrote:
>> hmm...add the devicetree-discuss@lists.ozlabs.org into list.
>>=20
>> Note that we are discussing a better naming for this new compatible =20
>> property in the corresponding [PATCH 2/2], so I will resend a v2 of =20
>> this patch.
>>=20
>>=20
>> On 07/01/2013 11:46 AM, hongbo.zhang@freescale.com wrote:
>>> From: Hongbo Zhang <hongbo.zhang@freescale.com>
>>>=20
>>> Freescale QorIQ T4 and B4 introduce new 8-channel DMA engines, this =20
>>> patch add
>>> the device tree nodes for them.
>>>=20
>>> Signed-off-by: Hongbo Zhang <hongbo.zhang@freescale.com>
>>> ---
>>>   arch/powerpc/boot/dts/fsl/qoriq-dma2-0.dtsi |   90 =20
>>> +++++++++++++++++++++++++++
>>>   arch/powerpc/boot/dts/fsl/qoriq-dma2-1.dtsi |   90 =20
>>> +++++++++++++++++++++++++++
>>>   arch/powerpc/boot/dts/fsl/t4240si-post.dtsi |    4 +-
>>>   3 files changed, 182 insertions(+), 2 deletions(-)
>>>   create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-dma2-0.dtsi
>>>   create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-dma2-1.dtsi
> Scott, any comment of these two file names?

There's "dma2" again...

How about elo3-dma-<n>.dtsi?

-Scott=
