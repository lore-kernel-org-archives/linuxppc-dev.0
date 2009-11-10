Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f199.google.com (mail-yw0-f199.google.com
	[209.85.211.199]) by ozlabs.org (Postfix) with ESMTP id 6DB07B7067
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Nov 2009 10:04:54 +1100 (EST)
Received: by ywh37 with SMTP id 37so527080ywh.17
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Nov 2009 15:04:52 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1257882180.14374.3@antares>
References: <1257882180.14374.3@antares>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 10 Nov 2009 12:59:22 -0700
Message-ID: <fa686aa40911101159y7bef3f9bte74e9aeb5c6e864b@mail.gmail.com>
Subject: Re: [PATCH 3/3] mpc52xx/wdt: WDT uses GPT api
To: =?ISO-8859-1?Q?Albrecht_Dre=DF?= <albrecht.dress@arcor.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linux PPC Development <linuxppc-dev@ozlabs.org>,
	devicetree-discuss@lists.ozlabs.org, Wim Van Sebroeck <wim@iguana.be>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Nov 10, 2009 at 12:43 PM, Albrecht Dre=DF <albrecht.dress@arcor.de>=
 wrote:
> Use the MPC5200 GPT api for the WDT which drastically simplifies this fil=
e.
>
> Signed-off-by: Albrecht Dre=DF <albrecht.dress@arcor.de>
> ---
>
> =A0drivers/watchdog/mpc5200_wdt.c | =A0246 +++++++++++-------------------=
----------
> =A01 files changed, 65 insertions(+), 181 deletions(-)


Can the WDT functionality just be merged entirely into
arch/powerpc/platforms/52xx/mpc52xx_gpt.c, eliminating the need for
this file entirely?  I think I'd rather have all the GPT "built in"
behaviour handled by a single driver.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
