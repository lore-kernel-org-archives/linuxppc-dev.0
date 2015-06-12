Return-Path: <lambert.quentin@gmail.com>
Received: from mail-wi0-x22d.google.com (mail-wi0-x22d.google.com
 [IPv6:2a00:1450:400c:c05::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D31591A09D6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2015 20:01:48 +1000 (AEST)
Received: by wigg3 with SMTP id g3so12175509wig.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2015 03:01:44 -0700 (PDT)
Message-ID: <557AAE06.7020002@gmail.com>
Date: Fri, 12 Jun 2015 12:01:42 +0200
From: Quentin Lambert <lambert.quentin@gmail.com>
MIME-Version: 1.0
To: Andreas Schwab <schwab@linux-m68k.org>
CC: Johannes Berg <johannes@sipsolutions.net>,
 Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.de>, linuxppc-dev@lists.ozlabs.org,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v3] ALSA: aoa: convert bus code to use dev_groups
References: <1432817307-28380-1-git-send-email-lambert.quentin@gmail.com>	<1434098322-12178-1-git-send-email-lambert.quentin@gmail.com>
 <87mw05w8kz.fsf@igel.home>
In-Reply-To: <87mw05w8kz.fsf@igel.home>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 12/06/2015 11:59, Andreas Schwab wrote:
> Quentin Lambert <lambert.quentin@gmail.com> writes:
>
>> The dev_attrs field of struct bus_type is going away, sue dev_groups instead.
> s/sue/use/
I meant use do you need to fix something else or should I resend with 
the typo correction ?

Quentin
