Return-Path: <glikely@secretlab.ca>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.31])
	by ozlabs.org (Postfix) with ESMTP id 9C3A4DDF12
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Jun 2008 15:49:37 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so362887ywh.39
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jun 2008 22:49:36 -0700 (PDT)
Message-ID: <fa686aa40806272249l7eae0c34k43a20ad41672b77a@mail.gmail.com>
Date: Fri, 27 Jun 2008 22:49:36 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: monstr@seznam.cz
Subject: Re: [PATCH 12/60] microblaze_v4: Generic dts file for platforms
In-Reply-To: <1214483429-32360-13-git-send-email-monstr@seznam.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1214483429-32360-1-git-send-email-monstr@seznam.cz>
	<1214483429-32360-5-git-send-email-monstr@seznam.cz>
	<1214483429-32360-6-git-send-email-monstr@seznam.cz>
	<1214483429-32360-7-git-send-email-monstr@seznam.cz>
	<1214483429-32360-8-git-send-email-monstr@seznam.cz>
	<1214483429-32360-9-git-send-email-monstr@seznam.cz>
	<1214483429-32360-10-git-send-email-monstr@seznam.cz>
	<1214483429-32360-11-git-send-email-monstr@seznam.cz>
	<1214483429-32360-12-git-send-email-monstr@seznam.cz>
	<1214483429-32360-13-git-send-email-monstr@seznam.cz>
Cc: linux-arch@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
	Michal Simek <monstr@monstr.eu>, vapier.adi@gmail.com,
	arnd@arndb.de, matthew@wil.cx, microblaze-uclinux@itee.uq.edu.au,
	linux-kernel@vger.kernel.org, drepper@redhat.com,
	linuxppc-dev@ozlabs.org, will.newton@gmail.com, hpa@zytor.com,
	John.Linn@xilinx.com, john.williams@petalogix.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jun 26, 2008 at 5:29 AM,  <monstr@seznam.cz> wrote:
> From: Michal Simek <monstr@monstr.eu>
>
>
> Signed-off-by: Michal Simek <monstr@monstr.eu>
> ---
>  arch/microblaze/platform/generic/system.dts |  300 +++++++++++++++++++++++++++
>  1 files changed, 300 insertions(+), 0 deletions(-)
>  create mode 100644 arch/microblaze/platform/generic/system.dts

Since this is a generated file, and entirely bitstream specific, does
it make sense to include it in the kernel tree?  If it does, then is
it produced from one of the Xilinx reference designs?  Can you add
documentation to the header that specifies exactly which design
version this .dts is for?

>
> diff --git a/arch/microblaze/platform/generic/system.dts b/arch/microblaze/platform/generic/system.dts
> new file mode 100644
> index 0000000..724a037
> --- /dev/null
> +++ b/arch/microblaze/platform/generic/system.dts
> @@ -0,0 +1,300 @@
> +/*
> + * (C) Copyright 2007-2008 Xilinx, Inc.
> + * (C) Copyright 2007-2008 Michal Simek
> + *
> + * Michal SIMEK <monstr@monstr.eu>

If this is a generated file, then is this copyright notice even appropriate?

> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of
> + * the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
> + * MA 02111-1307 USA

I don't this whole large legal block is necessary.  Unless specified
otherwise in the comment block, I believe GPL licencing is pretty much
assumed and so the above three copyrights should be redundant.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
