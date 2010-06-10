Return-Path: <glikely@secretlab.ca>
Received: from mail-gw0-f51.google.com (mail-gw0-f51.google.com [74.125.83.51])
	by ozlabs.org (Postfix) with ESMTP id 951FE1007D2
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 11 Jun 2010 08:11:42 +1000 (EST)
Received: by gwaa18 with SMTP id a18so371697gwa.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Jun 2010 15:11:41 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1276015562-28928-2-git-send-email-emillbrandt@dekaresearch.com>
References: <1276015562-28928-1-git-send-email-emillbrandt@dekaresearch.com>
	<1276015562-28928-2-git-send-email-emillbrandt@dekaresearch.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 10 Jun 2010 16:11:21 -0600
Message-ID: <AANLkTinIZNVUDMbmULdd-cO47aAh0p4F5mPh1I27dgRR@mail.gmail.com>
Subject: Re: [PATCH 1/2] powerpc/5200: Export port-config
To: Eric Millbrandt <emillbrandt@dekaresearch.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 8, 2010 at 10:46 AM, Eric Millbrandt
<emillbrandt@dekaresearch.com> wrote:
> Allow device drivers to safely modify port-config. =A0This allows device =
drivers
> access to gpio pins to manually bit-bang slave devices.
>
> Signed-off-by: Eric Millbrandt <emillbrandt@dekaresearch.com>

Unfortunately, still too much exposure of port-config to drivers for
my liking.  I'd be happier with an API that requests the mode for a
specific pin group instead of directly masking & setting bits....

but of course I've also just said in my other email that I'd be happy
with all of the GPIO AC97reset logic being contained in
arch/powerpc/platforms/52xx which kind of makes the comment moot.  :-)

g.

> ---
> =A0arch/powerpc/include/asm/mpc52xx.h =A0 =A0 =A0 =A0 =A0 | =A0 =A02 +
> =A0arch/powerpc/platforms/52xx/mpc52xx_common.c | =A0 61 ++++++++++++++++=
++++++++++
> =A02 files changed, 63 insertions(+), 0 deletions(-)
