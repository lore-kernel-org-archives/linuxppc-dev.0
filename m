Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from SG2EHSOBE005.bigfish.com (sg2ehsobe002.messaging.microsoft.com
	[207.46.51.76]) by ozlabs.org (Postfix) with ESMTP id 1F47AB7D1B
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 17 Jun 2010 06:35:33 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Subject: RE: [PATCHv3] [RFC] Xilinx Virtex 4 FX Soft FPU support
Date: Wed, 16 Jun 2010 13:19:11 -0700
In-Reply-To: <AANLkTinx5nCwng6tFz8h1VC_2qZ69xMF1SCCGD9iv3MM@mail.gmail.com>
References: <201005262104.48938.temerkhanov@cifronik.ru>
	<AANLkTinx5nCwng6tFz8h1VC_2qZ69xMF1SCCGD9iv3MM@mail.gmail.com>
From: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
To: "Grant Likely" <grant.likely@secretlab.ca>,
	"Sergey Temerkhanov" <temerkhanov@cifronik.ru>
Message-ID: <f96e5430-02c9-4e88-af8b-67592b3b1916@SG2EHSMHS001.ehs.local>
Cc: John Linn <linnj@xilinx.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: linuxppc-dev-bounces+stephen=3Dneuendorffer.name@lists.ozlabs.org [=
mailto:linuxppc-dev-
> bounces+stephen=3Dneuendorffer.name@lists.ozlabs.org] On Behalf Of Grant =
Likely
> Sent: Wednesday, June 16, 2010 1:02 PM
> To: Sergey Temerkhanov
> Cc: linuxppc-dev@lists.ozlabs.org; John Linn
> Subject: Re: [PATCHv3] [RFC] Xilinx Virtex 4 FX Soft FPU support
> =

> On Wed, May 26, 2010 at 11:04 AM, Sergey Temerkhanov
> <temerkhanov@cifronik.ru> wrote:
> > This patch enables support for Xilinx Virtex 4 FX singe-float FPU.
> >
> > Changelog v2-v3:
> > =A0 =A0 =A0 =A0-Fixed whitespaces for SAVE_FPR/REST_FPR.
> > =A0 =A0 =A0 =A0-Changed description of MSR_AP bit.
> > =A0 =A0 =A0 =A0-Removed the stub for APU unavailable exception.
> >
> > Changelog v1->v2:
> > =A0 =A0 =A0 =A0-Added MSR_AP bit definition
> > =A0 =A0 =A0 =A0-Renamed CONFIG_XILINX_FPU to CONFIG_XILINX_SOFTFPU, mov=
ed it to
> > =A0 =A0 =A0 =A0 'Platform support' and made it Virtex4-FX-only.
> > =A0 =A0 =A0 =A0-Changed SAVE_FPR/REST_FPR definition style.
> >
> > Caveats:
> > =A0 =A0 =A0 =A0- Hard-float binaries which rely on in-kernel math emula=
tion will
> > =A0 =A0 =A0 =A0give wrong results since they expect 64-bit double-preci=
sion instead of
> > =A0 =A0 =A0 =A032-bit single-precision numbers which Xilinx V4-FX Soft =
FPU produces.

Perhaps this caveat should go in the description of the configuration optio=
n?

Steve


This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
