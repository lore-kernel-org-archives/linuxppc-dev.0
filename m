Return-Path: <John.Linn@xilinx.com>
Received: from outbound5-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id BD736DDF01
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  3 Apr 2008 02:23:43 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: Virtex V5FX PPC 440 Support In Xilinx Git Tree
Date: Wed, 2 Apr 2008 09:23:30 -0600
In-Reply-To: <87lk3w8u00.fsf@macbook.be.48ers.dk>
References: <20080401234142.41B13191804A@mail111-sin.bigfish.com>
	<87lk3w8u00.fsf@macbook.be.48ers.dk>
From: "John Linn" <John.Linn@xilinx.com>
To: "Peter Korsgaard" <jacmet@sunsite.dk>
Message-Id: <20080402152332.0AF84F08087@mail88-dub.bigfish.com>
Cc: git <git@xilinx.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Peter,

We added arch/ppc support because it was the easiest path for us.  We
realize it's going away soon in the mainline.

We are working on getting arch/powerpc more mature for both the 405 and
the 440 as we do believe this is the future for powerpc.

Thanks,
John



-----Original Message-----
From: Peter Korsgaard [mailto:jacmet@gmail.com] On Behalf Of Peter
Korsgaard
Sent: Wednesday, April 02, 2008 3:51 AM
To: John Linn
Cc: linuxppc-embedded@ozlabs.org; git
Subject: Re: Virtex V5FX PPC 440 Support In Xilinx Git Tree

>>>>> "John" =3D=3D John Linn <John.Linn@xilinx.com> writes:

 John> I pushed PowerPC 440 support to the Xilinx Git server with
 John> support for ppc arch and with powerpc arch support coming in
 John> the near future.

Neat, but why have you added arch/ppc support? It's supposed to go
away pretty much by the time the hardware gets in the hand of
developers.

--=20
Bye, Peter Korsgaard
