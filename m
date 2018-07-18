Return-Path: <linux-kernel@hansmi.ch>
Received: from mail-lf0-x242.google.com (mail-lf0-x242.google.com
 [IPv6:2a00:1450:4010:c07::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41W3th2MKLzF35L
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jul 2018 03:24:54 +1000 (AEST)
Received: by mail-lf0-x242.google.com with SMTP id f18-v6so4022893lfc.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jul 2018 10:24:54 -0700 (PDT)
Sender: Michael Hanselmann <hansmi@hansmi.ch>
Subject: Re: [PATCH] Mark ams driver as orphaned in MAINTAINERS
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <8fe08e4d44c56ee0b70517fc8609ab5a116bc407.1517265227.git.linux-kernel@hansmi.ch>
 <877elsq2xh.fsf@concordia.ellerman.id.au>
From: Michael Hanselmann <linux-kernel@hansmi.ch>
Message-ID: <04170342-6779-5e17-69c9-f0d87a3cc5a1@hansmi.ch>
Date: Wed, 18 Jul 2018 19:24:48 +0200
MIME-Version: 1.0
In-Reply-To: <877elsq2xh.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 18.07.2018 12:00, Michael Ellerman wrote:
> Michael Hanselmann <linux-kernel@hansmi.ch> writes:
>> I no longer have any hardware with the Apple motion sensor and thus
>> relinquish maintainership of the driver.
> 
> Thanks. I think I'll just remove the whole entry, meaning it will be
> caught under the "LINUX FOR POWER MACINTOSH" entry.
> 
> Unless you object. Full patch below.

Sounds good to me.

Reviewed-by: Michael Hanselmann <linux-kernel@hansmi.ch>
