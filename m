Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (mail.lixom.net [70.86.134.90])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B23BEB70DF
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  6 Sep 2010 08:30:56 +1000 (EST)
Date: Sun, 5 Sep 2010 17:23:40 -0500
From: Olof Johansson <olof@lixom.net>
To: Tirumala Marri <tmarri@apm.com>
Subject: Re: [PATCH] APM821xx: Add support for new SoC APM821xx
Message-ID: <20100905222340.GC2150@lixom.net>
References: <1283464653-18492-1-git-send-email-tmarri@apm.com>
	<20100903020851.GC29732@hansolo.jdub.homelinux.org>
	<197d4509c0b1206ce2d686c03701a6b4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <197d4509c0b1206ce2d686c03701a6b4@mail.gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 03, 2010 at 01:38:46PM -0700, Tirumala Marri wrote:
> > >APM821xx is Applied Micro Circuits Corporations naming convention for
> > >new line of SoCs.
> >
> > So is it a 440x6 core then?  Or what core is inside the SoC?
> [Marri] It is 464 core.

Then the device tree identifier, and the cpu setup functions, etc, should indicate
464, not APM821xx.

Also, why add yet another defconfig? Isn't the eval board similar to
many others and can be supported with just a tweak of some existing
common defconfig instead?


-Olof
