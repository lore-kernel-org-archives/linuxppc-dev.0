Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound5-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 89DABDE42D
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  7 May 2008 03:31:09 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: Linux for ml410
Date: Tue, 6 May 2008 10:31:00 -0700
In-reply-to: <008901c8af9e$b335cc00$19a16400$@com>
References: <520220685@web.de><fa686aa40801071302u78d01f11y5c489553e06c0c01@mail.gmail.com>
	<008901c8af9e$b335cc00$19a16400$@com>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "mojtaba" <kernelppc@gmail.com>,
	<linuxppc-embedded@ozlabs.org>
Message-Id: <20080506173102.2E244EF8062@mail10-dub.bigfish.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


I'm guessing you used the standard BSP generation process, which
overwrites files in the kernel.  Instead, you should generate the BSP
into a dummy directory and copy only the xparameters_*.h file over to
the kernel.  This is all that is needed in the git tree, since it
contains all of the required drivers.

Steve

> -----Original Message-----
> From: linuxppc-embedded-bounces+stephen=3Dneuendorffer.name@ozlabs.org
[mailto:linuxppc-embedded-
> bounces+stephen=3Dneuendorffer.name@ozlabs.org] On Behalf Of mojtaba
> Sent: Tuesday, May 06, 2008 10:29 AM
> To: linuxppc-embedded@ozlabs.org
> Subject: Linux for ml410
>=20
> Dear All,
> I am trying to compile Linux 2.6.25(which I got from git.xilinx) for
ML410
> board and I have a problem during compilation. This is the error
message:
>=20
>  CC      arch/ppc/platforms/4xx/xilinx_generic_mlxxx.o
> arch/ppc/platforms/4xx/xilinx_generic_mlxxx.c: In function
> 'virtex_device_fixup':
> arch/ppc/platforms/4xx/xilinx_generic_mlxxx.c:31: error: dereferencing
> pointer to incomplete type
> make[1]: *** [arch/ppc/platforms/4xx/xilinx_generic_mlxxx.o] Error 1
> make: *** [arch/ppc/platforms/4xx] Error 2
>=20
> it seems that xlltemac_platform_data structure is not recognized by
the
> compiler so it cannot dereference it. I do not know what this
structure is
> and where it has been defined. I really appreciate if you can help me.
> Best regards,
> Mojtaba
>=20
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
