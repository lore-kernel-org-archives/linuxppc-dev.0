Return-Path: <timur.tabi@gmail.com>
Received: from mail-vw0-f42.google.com (mail-vw0-f42.google.com
	[209.85.212.42]) by ozlabs.org (Postfix) with ESMTP id 46A65B6EF1
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Aug 2010 06:36:24 +1000 (EST)
Received: by vws18 with SMTP id 18so590676vws.15
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Aug 2010 13:36:22 -0700 (PDT)
MIME-Version: 1.0
Sender: timur.tabi@gmail.com
In-Reply-To: <20100801074831.1099.3318.stgit@angua>
References: <20100801074831.1099.3318.stgit@angua>
Date: Thu, 19 Aug 2010 15:36:21 -0500
Message-ID: <AANLkTiny_N-UqzuVaftLj75e_b0PjsdHstH8ZKx5mw7O@mail.gmail.com>
Subject: Re: [PATCH] of/device: Replace struct of_device with struct
	of_platform
From: Timur Tabi <timur@freescale.com>
To: Grant Likely <grant.likely@secretlab.ca>
Content-Type: text/plain; charset=ISO-8859-1
Cc: sfr@canb.auug.org.au, monstr@monstr.eu,
	alsa-devel mailing list <alsa-devel@alsa-project.org>,
	microblaze-uclinux@itee.uq.edu.au, devicetree-discuss@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	sparclinux@vger.kernel.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Aug 1, 2010 at 2:57 AM, Grant Likely <grant.likely@secretlab.ca> wr=
ote:

> =A0sound/soc/fsl/mpc8610_hpcd.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =
=A04 +-

This file is/was significantly rewritten for 2.6.37.  I posted a fix
to the alsa mailing list, but it will conflict with your patch.  You
might want to remove all changes to sound/soc/fsl from this commit.

--=20
Timur Tabi
Linux kernel developer at Freescale
