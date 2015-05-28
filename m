Return-Path: <lambert.quentin@gmail.com>
Received: from mail-wg0-x230.google.com (mail-wg0-x230.google.com
 [IPv6:2a00:1450:400c:c00::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A24221A15ED
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2015 23:59:54 +1000 (AEST)
Received: by wgbgq6 with SMTP id gq6so37346542wgb.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2015 06:59:50 -0700 (PDT)
Message-ID: <55671F56.6080402@gmail.com>
Date: Thu, 28 May 2015 15:59:50 +0200
From: Quentin Lambert <lambert.quentin@gmail.com>
MIME-Version: 1.0
To: Takashi Iwai <tiwai@suse.de>
CC: Johannes Berg <johannes@sipsolutions.net>,
 Jaroslav Kysela <perex@perex.cz>,
 linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] ALSA: aoa: convert bus code to use dev_groups
References: <1432817307-28380-1-git-send-email-lambert.quentin@gmail.com>
 <s5hwpzs7qrz.wl-tiwai@suse.de>
In-Reply-To: <s5hwpzs7qrz.wl-tiwai@suse.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 28/05/2015 15:52, Takashi Iwai wrote:
> At Thu, 28 May 2015 14:48:27 +0200,
> Quentin Lambert wrote:
>> You should use dev_groups instead of the dev_attrs field of struct
>> bus_type. This converts the MDIO bus code to use the correct field.
>>
>> These modifications were made using Coccinelle.
>>
>> Signed-off-by: Quentin Lambert <lambert.quentin@gmail.com>
> What's wrong with dev_attrs?
> (Not offending, I'm just curious where the preference for dev_groups
>   is referred...)

This patch is based on commit 4192c74940e23da727eb02b7b4ee779dde2f670,
its message indicates that dev_attrs is going away.

Quentin
