Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.182])
	by ozlabs.org (Postfix) with ESMTP id 2C461DDEA0
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 04:53:55 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so314224wag
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 11:53:52 -0700 (PDT)
Message-ID: <fa686aa40710181153w7bb794ceve38e7802d603ad42@mail.gmail.com>
Date: Thu, 18 Oct 2007 12:53:52 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Marian Balakowicz" <m8@semihalf.com>
Subject: Re: [PATCH v2 3/4] [POWERPC] Add restart support for mpc52xx based
	platforms
In-Reply-To: <20071018184433.3584.77107.stgit@hekate.izotz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071018184407.3584.3513.stgit@hekate.izotz.org>
	<20071018184433.3584.77107.stgit@hekate.izotz.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/18/07, Marian Balakowicz <m8@semihalf.com> wrote:
> Add common helper routines: mpc52xx_map_wdt() and mpc52xx_restart().
>
> This patch relies on Sascha Hauer's patch published in:
> http://patchwork.ozlabs.org/linuxppc/patch?id=8910.

By 'relies', do you mean "depends on" or "was derived from"?

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
