Return-Path: <ppc.addon@gmail.com>
Received: from mail-vx0-f179.google.com (mail-vx0-f179.google.com
	[209.85.220.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 086C1B6F72
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  4 Oct 2011 22:57:03 +1100 (EST)
Received: by vcbf1 with SMTP id f1so270396vcb.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 04 Oct 2011 04:57:00 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 4 Oct 2011 13:56:57 +0200
Message-ID: <CABMX=Wxbm+v0ntPT2Br6D_xSpe7XhASEoxzq99ExoYUZ4eDj5A@mail.gmail.com>
Subject: ping: [PATCH] GXT4000P and GXT6500P support
From: nello martuscielli <ppc.addon@gmail.com>
To: linuxppc-dev@lists.ozlabs.org, linux-fbdev-devel@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1
Cc: Nico Macrionitisl <acrux@cruxppc.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

ping for: http://lists.ozlabs.org/pipermail/linuxppc-dev/2009-June/072678.html

This patch adds support for GXT4000P and GXT6500P cards found on some
IBM pSeries machines.
GXT4000P/6000P and GXT4500P/6500P  couples are  identical from
software's point of view and are based on the same  Raster Engine
(RC1000), except for a different reference clock for the PLL.
GXT6x00P models are equipped with an additional Geometry Engine
(GT1000) but this driver doesn't use it.


I see that even after 2 years, this patch still hasn't been added to
the official Linux kernel.
You will appreciate how little code this took to save everybody with a
GXT6500P card some trouble.

cheers,
Nello
--
CRUX PPC user on IBM POWER4+
