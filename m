Return-Path: <John.Linn@xilinx.com>
Received: from IE1EHSOBE005.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16]) by ozlabs.org (Postfix) with ESMTP id A40F5DE180
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jun 2008 23:51:05 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Subject: RE: [PATCH] [RFC] powerpc: Xilinx: adding virtex5 powerpc 440 support
Date: Tue, 24 Jun 2008 07:50:53 -0600
In-Reply-To: <87d4m79vpu.fsf@macbook.be.48ers.dk>
References: <20080623162856.D5FA41CA806C@mail66-dub.bigfish.com><20080623150846.40d65f08@zod.rchland.ibm.com><20080623213038.490C110B806B@mail11-dub.bigfish.com>
	<87d4m79vpu.fsf@macbook.be.48ers.dk>
From: John Linn <John.Linn@xilinx.com>
To: "Peter Korsgaard" <jacmet@sunsite.dk>
Message-ID: <20080624135054.8A1ACA4806C@mail121-dub.bigfish.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Yes it is compatible with the normal powerpc FPU.

Thanks,
John

-----Original Message-----
From: Peter Korsgaard [mailto:jacmet@gmail.com] On Behalf Of Peter
Korsgaard
Sent: Tuesday, June 24, 2008 12:46 AM
To: John Linn
Cc: Josh Boyer; linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] [RFC] powerpc: Xilinx: adding virtex5 powerpc 440
support

>>>>> "John" =3D=3D John Linn <John.Linn@xilinx.com> writes:

Hi John,

 >>> +config PPC_FPU
 >>> +	depends on XILINX_VIRTEX_5_FXT
 >>> +	bool "Enable Xilinx Soft FPU"
 >>> +	help
 >>> +	  This option enables the Xilinx Soft FPU attached to the APU
 >>> +	  interface of the PPC440 (requires DP_FULL FPU pcore).
 >> =

 >> There is already a PPC_FPU option in platforms/Kconfig.cputype

Is the Xilinx soft FPU compatible with the normal powerpc FPU?

-- =

Bye, Peter Korsgaard


This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
