Return-Path: <glikely@secretlab.ca>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 355D9B6F76
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  3 May 2011 23:22:43 +1000 (EST)
Received: by iwc10 with SMTP id 10so50621iwc.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 03 May 2011 06:22:40 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <4DBFADBE.5040603@denx.de>
References: <1291451028-22532-1-git-send-email-hs@denx.de>
	<1300782452-528-1-git-send-email-hs@denx.de>
	<20110502221406.GA15043@ponder.secretlab.ca> <4DBF8FF6.8030100@denx.de>
	<BANLkTimacM29RHExZounuziF+7jARQxdTg@mail.gmail.com>
	<4DBFADBE.5040603@denx.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 3 May 2011 07:22:20 -0600
Message-ID: <BANLkTi=b_ySGOxb2jXCvKdniesdNhqoUpQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] powerpc, 52xx: add charon board support
To: hs@denx.de
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-fbdev@vger.kernel.org, devicetree-discuss@ozlabs.org,
	Samuel Ortiz <sameo@linux.intel.com>, Vincent Sanders <vince@simtec.co.uk>,
	linux-kernel@vger.kernel.org, Ben Dooks <ben@simtec.co.uk>,
	Randy Dunlap <rdunlap@xenotime.net>,
	Paul Mundt <lethal@linux-sh.org>, linuxppc-dev@lists.ozlabs.org,
	Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 3, 2011 at 1:24 AM, Heiko Schocher <hs@denx.de> wrote:
>
> Ok. Done, just one more question:
>
> Why you didn;t pick up the patches:
>
> - powerpc, 5200: add support for charon board
> =A0(Got an Acked-by from Wolfram Sang)
> - powerpc, video: add SM501 support for charon board.

I did pick them up and they are in my tree.  Actually, I squashed
those two together since there was no reason to have them split apart.

g.
