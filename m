Return-Path: <ryabinin.a.a@gmail.com>
Received: from mail-wi0-x22f.google.com (mail-wi0-x22f.google.com
 [IPv6:2a00:1450:400c:c05::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2C80F1A1DE4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2015 03:02:52 +1000 (AEST)
Received: by wicja10 with SMTP id ja10so50641656wic.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Aug 2015 10:02:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1440577578-15813-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1440577578-15813-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1440577578-15813-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Date: Wed, 26 Aug 2015 20:02:48 +0300
Message-ID: <CAPAsAGytyWEwd2+TMRCJq4B3e79mKMsq3M2k_Bts17TQbn1z2g@mail.gmail.com>
Subject: Re: [PATCH V2 03/10] kasan: Rename kasan_enabled to
 kasan_report_enabled
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, paulus@samba.org,
 mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2015-08-26 11:26 GMT+03:00 Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>:
> The function only disable/enable reporting. In the later patch
> we will be adding a kasan early enable/disable. Rename kasan_enabled
> to properly reflect its function.
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Reviewed-by: Andrey Ryabinin <ryabinin.a.a@gmail.com>
