Return-Path: <jwboyer@gmail.com>
Received: from mail-vx0-f179.google.com (mail-vx0-f179.google.com
 [209.85.220.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3FBD2B6EF1
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Mar 2012 09:15:33 +1100 (EST)
Received: by vcbf11 with SMTP id f11so4021013vcb.38
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Mar 2012 14:15:31 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20120306.170819.2135873666210523674.davem@davemloft.net>
References: <1330920224-3006-1-git-send-email-dhdang@apm.com>
 <1330945062-15760-1-git-send-email-dhdang@apm.com>
 <20120306.170819.2135873666210523674.davem@davemloft.net>
Date: Tue, 6 Mar 2012 17:15:30 -0500
Message-ID: <CA+5PVA56KhuBjbszR8_k_OAyQc=1fHxbMXE4ZFO9ahANVJi_Ww@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] powerpc/44x: Add new compatible value for EMAC
 node of APM821XX dts file.
From: Josh Boyer <jwboyer@gmail.com>
To: David Miller <davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: dhdang@apm.com, linux-kernel@vger.kernel.org, paulus@samba.org,
 netdev@vger.kernel.org, sr@denx.de, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 6, 2012 at 5:08 PM, David Miller <davem@davemloft.net> wrote:
> From: Duc Dang <dhdang@apm.com>
> Date: Mon, =A05 Mar 2012 17:57:42 +0700
>
>> This compatible value will be used to distinguish some special features =
of APM821XX EMAC: no half duplex mode support, configuring jumbo frame.
>>
>> Signed-off-by: Duc Dang <dhdang@apm.com>
>
> Applied.

So I guess we're taking these through your tree?  I guess that works out
well enough since the other patches I was going to send to Ben aren't
panning out anyway.

josh
