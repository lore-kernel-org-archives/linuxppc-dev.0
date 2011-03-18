Return-Path: <Alexandre.Bounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 1C15EB6F73
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 19 Mar 2011 07:53:51 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH -mm] RapidIO,powerpc/85xx: Fix configuration option
Date: Fri, 18 Mar 2011 13:53:08 -0700
Message-ID: <0CE8B6BE3C4AD74AB97D9D29BD24E55201A587FE@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <8E8332C6-1F17-4EC1-BD04-7B93D7B49640@kernel.crashing.org>
References: <1300468735-1158-1-git-send-email-alexandre.bounine@idt.com>
	<8E8332C6-1F17-4EC1-BD04-7B93D7B49640@kernel.crashing.org>
From: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, Thomas Moll <thomas.moll@sysgo.com>,
	akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch has to be applied to -mm tree. Andrew already has set of
patches that change RapidIO configuration.
I think it will be better if it goes into -mm to keep things aligned
properly.

Alex.

-----Original Message-----
From: Kumar Gala [mailto:galak@kernel.crashing.org]=20
Sent: Friday, March 18, 2011 4:49 PM
To: Bounine, Alexandre
Cc: akpm@linux-foundation.org; linux-kernel@vger.kernel.org;
linuxppc-dev@lists.ozlabs.org; Matt Porter; Li Yang; Thomas Moll
Subject: Re: [PATCH -mm] RapidIO,powerpc/85xx: Fix configuration option


On Mar 18, 2011, at 12:18 PM, Alexandre Bounine wrote:

> Follows set of patches in -mm tree. Replaces configuration option
> missed in previous patches.
>=20
> Signed-off-by: Alexandre Bounine <alexandre.bounine@idt.com>
> ---
> arch/powerpc/kernel/cpu_setup_fsl_booke.S |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)

Acked-by: Kumar Gala <galak@kernel.crashing.org>

Alex, I can push this via the powerpc.git tree route if you want.

- k
