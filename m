Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound5-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 0FB76DE77A
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Apr 2008 04:51:50 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: Problems of using APU/FPU under linux
Date: Tue, 15 Apr 2008 11:50:49 -0700
In-reply-to: <8092B58B-4C3F-4F29-83A9-F53DA23F10F8@gmail.com>
References: <287479FF-A7FC-4B48-BE1E-FDDCB97D55A9@gmail.com>
	<977C41F842E66D4CB2E41332313B615005CB0A39@XSJ-EXCHVS1.xlnx.xilinx.com>
	<20080414183255.F056C1C300A3@mail62-sin.bigfish.com>
	<1B35E815-094F-40CB-AEDA-C04A6CBECC07@gmail.com>
	<JO200804160320143.12198109@co-nss.co.jp>
	<607F58E8-CB29-4BD7-9886-DF3C8B495ED7@gmail.com>
	<20080415183706.C694717D807B@mail80-dub.bigfish.com>
	<8092B58B-4C3F-4F29-83A9-F53DA23F10F8@gmail.com>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "Shanyuan Gao" <sygao.research@gmail.com>, <linuxppc-embedded@ozlabs.org>
Message-Id: <20080415185049.A1E8A71006F@mail203-sin.bigfish.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Shanyuan Gao [mailto:sygao.research@gmail.com]
> Sent: Tuesday, April 15, 2008 11:47 AM
> To: Stephen Neuendorffer; linuxppc-embedded@ozlabs.org
> Cc: John Bonesio; Yoshio Kashiwagi
> Subject: Re: Problems of using APU/FPU under linux
>=20
> No, actually I am using head_4xx.S and I cannot find FPU_UNAVAILABLE
> in there. Do I need to set it?

Yes, I think this is why you are getting the unknown trap.  It appears
that 405's usually don't have FPU and so the code was never put there.

Steve
