Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F2E7C1A0456
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2015 20:08:05 +1000 (AEST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Quentin Lambert <lambert.quentin@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.de>, linuxppc-dev@lists.ozlabs.org,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v3] ALSA: aoa: convert bus code to use dev_groups
References: <1432817307-28380-1-git-send-email-lambert.quentin@gmail.com>
 <1434098322-12178-1-git-send-email-lambert.quentin@gmail.com>
Date: Fri, 12 Jun 2015 11:59:40 +0200
In-Reply-To: <1434098322-12178-1-git-send-email-lambert.quentin@gmail.com>
 (Quentin Lambert's message of "Fri, 12 Jun 2015 10:38:41 +0200")
Message-ID: <87mw05w8kz.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Quentin Lambert <lambert.quentin@gmail.com> writes:

> The dev_attrs field of struct bus_type is going away, sue dev_groups instead.

s/sue/use/

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
