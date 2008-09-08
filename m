Return-Path: <phazarika@amcc.com>
Received: from sdcmail02.amcc.com (sdcmail02.amcc.com [198.137.200.73])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "Messaging Gateway Appliance Demo Cert",
	Issuer "Messaging Gateway Appliance Demo Cert" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 31B42DDF91
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Sep 2008 07:06:06 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Question on 4xx GIT tree
Date: Mon, 8 Sep 2008 13:55:26 -0700
Message-ID: <0CA0A16855646F4FA96D25A158E299D604F7F1A4@SDCEXCHANGE01.ad.amcc.com>
From: "Prodyut Hazarika" <phazarika@amcc.com>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Josh,
I am planning to submit a patch to support 4K/16K and 64K page size for =
4xx processors.
I see that your git tree still has the include/asm-powerpc/* header =
files, while in Linus's git tree, the powerpc specific header file has =
been moved to arch/powerpc/include/asm.

Should I base my patch from your git tree or Linus's git tree? Please =
advice how to proceed since I want your efforts in merging as painless =
as possible.

Regards,
Prodyut Hazarika

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Staff S/w Engineer
AMCC
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
