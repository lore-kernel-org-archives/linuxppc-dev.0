Return-Path: <John.Linn@xilinx.com>
Received: from IE1EHSOBE002.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16]) by ozlabs.org (Postfix) with ESMTP id 9BA3EDDF0A
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 26 Jul 2008 07:55:06 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Subject: RE: Xilinx Linux 2.6 for XPS LL_TEMAC and LL_FIFO problem
Date: Fri, 25 Jul 2008 15:54:53 -0600
In-Reply-To: <18649823.post@talk.nabble.com>
References: <BAY115-W186EA84A950C17657AD8D9B20B0@phx.gbl><EDAE140DF1B2FC42B5867C22CA0B333FA99D2F@XMBIL132.northgrum.com><20080316214832.3F77A538046@mail141-sin.bigfish.com><18628194.post@talk.nabble.com><EDAE140DF1B2FC42B5867C22CA0B333FFA5D56@XMBIL132.northgrum.com><20080724132453.C8F1010F0077@mail56-dub.bigfish.com>
	<18649823.post@talk.nabble.com>
From: John Linn <John.Linn@xilinx.com>
To: "Mirek23" <miroslaw.dach@psi.ch>,
	<linuxppc-embedded@ozlabs.org>
Message-ID: <20080725215457.DE78A1228063@mail132-dub.bigfish.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

{resend as I forgot to send to the mailing list)

Hi Mirek,

Since this is a u-boot issue, we can move this conversation off this
list.

The u-boot that is in the git repository has not been tested on the
Virtex4 platform.

I have only tested on the ML507, Virtex 5 platform.

There's not a ML403/ML405 board supported in our git tree, so I'm
curious what you did to try to build it for V4.

There are differences between V4 and V5 with the DMA as it's hard in V5
and hangs off the DCR bus of the processor.

The kernel itself is running on both the ML405 and the ML507, but not
yet with u-boot.

Thanks,
John

> -----Original Message-----
> From: linuxppc-embedded-bounces+john.linn=3Dxilinx.com@ozlabs.org
[mailto:linuxppc-embedded-
> bounces+john.linn=3Dxilinx.com@ozlabs.org] On Behalf Of Mirek23
> Sent: Friday, July 25, 2008 5:22 AM
> To: linuxppc-embedded@ozlabs.org
> Subject: RE: Xilinx Linux 2.6 for XPS LL_TEMAC and LL_FIFO problem
> =

> =

> Hi John and Mike,
> =

> Thank you for your reply. We have modified out FPGA design and now we
have
> LL_TEMAC with LL_DMA component connected instead of the LL_FIFO.
Before
> building linux kernel we have tried to build the u-boot (downloaded
from the
> xilinx-git tree).
> =

> It was relatively easy to build u-boot which has the ll_temac with
ll_dma
> support.
> =

> next we have tried to run u-boot on our ppc (virtex-4 FX12). All went
fine
> till the moment to establish the communication with the network.
> =

> I put some debug messages to the xilinx ll_dma and ll_temac drivers
and we
> have found that u-boot hangs
> during dma initialisation:
> =

> more specifically in the function calls :
>        XLlDma_Initialize(XLlDma * InstancePtr, u32 BaseAddress)
>                XLlDma_Reset(XLlDma * InstancePtr)
>                          XLlDma_mBdRingSnapShotCurrBd(TxRingPtr);
> =

> Do you have any idea what could be wrong with dma initialization?
> =

> Best Regards
> =

> Mirek
> =

> =

> =

> --
> View this message in context:
http://www.nabble.com/Compile-time-error%2C-compiling-Xilinx-Linux-2.6-
> for-XPS-LLTEMAC-tp16065692p18649823.html
> Sent from the linuxppc-embedded mailing list archive at Nabble.com.
> =

> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded


This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
