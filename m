Return-Path: <mopsfelder@gmail.com>
Received: from mail-qk0-x243.google.com (mail-qk0-x243.google.com
 [IPv6:2607:f8b0:400d:c09::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xJMgC71pHzDrKC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jul 2017 05:36:55 +1000 (AEST)
Received: by mail-qk0-x243.google.com with SMTP id d145so16729408qkc.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jul 2017 12:36:55 -0700 (PDT)
Subject: Re: [PATCH v2] include/linux/vfio.h: Guard powerpc-specific functions
 with CONFIG_VFIO_SPAPR_EEH
To: Alex Williamson <alex.williamson@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
References: <20170718172220.9954-1-mopsfelder@gmail.com>
 <20170726133715.7cb039cb@w520.home>
From: =?UTF-8?Q?Murilo_Opsfelder_Ara=c3=bajo?= <mopsfelder@gmail.com>
Message-ID: <bb692565-c0da-c237-9b15-c433404e5f7f@gmail.com>
Date: Thu, 27 Jul 2017 16:36:47 -0300
MIME-Version: 1.0
In-Reply-To: <20170726133715.7cb039cb@w520.home>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/26/2017 04:37 PM, Alex Williamson wrote:
[...]
> Applied to my for-linus branch with David and Alexey's R-b for v4.13.
> Thanks,
> 
> Alex

Thank you all!

-- 
Murilo
