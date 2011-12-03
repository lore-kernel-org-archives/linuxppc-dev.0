Return-Path: <afleming@gmail.com>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
 [209.85.213.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id A47F6B6F9D
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  4 Dec 2011 07:15:48 +1100 (EST)
Received: by yenl7 with SMTP id l7so1071127yen.38
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 03 Dec 2011 12:15:44 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <B84C6222-2359-46D5-BA54-5024E43ECD3F@kernel.crashing.org>
References: <1322809549-32622-1-git-send-email-afleming@freescale.com>
 <1322809549-32622-2-git-send-email-afleming@freescale.com>
 <B84C6222-2359-46D5-BA54-5024E43ECD3F@kernel.crashing.org>
Date: Sat, 3 Dec 2011 14:15:44 -0600
Message-ID: <CAKWjMd52BhV0j3R93Cw8usBxZwbMCY70x=BAmV7dH-WyWRUyFA@mail.gmail.com>
Subject: Re: [PATCH] pq3: Add default tbi address
From: Andy Fleming <afleming@gmail.com>
To: Kumar Gala <galak@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, Andy Fleming <afleming@freescale.com>,
 David Miller <davem@davemloft.net>, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>> arch/powerpc/boot/dts/fsl/pq3-etsec1-0.dtsi | =A0 =A05 +++++
>> arch/powerpc/boot/dts/fsl/pq3-etsec2-0.dtsi | =A0 =A05 +++++
>> 2 files changed, 10 insertions(+), 0 deletions(-)
>
> This doesn't seem correct, meaning this should really be in the board .dt=
s not in the IP.
>
> I think the driver should check and warn if this property doesn't exist.

Hmm... in principle, I agree with you. I suppose I was just being
lazy, and avoiding changing all the device trees again. However, it's
not an unreasonable default. A search through *all* of the device
trees for the tbi node indicates that 0x11 is chosen about 50% of the
time.

However, I'll devise a patch which complains if the node isn't found,
and another patch which modifies all of the offending device trees.

Andy
