Return-Path: <ryabinin.a.a@gmail.com>
Received: from mail-lf0-x243.google.com (mail-lf0-x243.google.com
 [IPv6:2a00:1450:4010:c07::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yHJdw6s1lzDrG1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 04:17:24 +1100 (AEDT)
Received: by mail-lf0-x243.google.com with SMTP id r129so6650243lff.8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Oct 2017 10:17:24 -0700 (PDT)
Subject: Re: [PATCH v12 07/11] x86/kasan: add and use kasan_map_populate()
To: Pavel Tatashin <pasha.tatashin@oracle.com>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>, linux-kernel@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org,
 kasan-dev@googlegroups.com, borntraeger@de.ibm.com,
 heiko.carstens@de.ibm.com, davem@davemloft.net, willy@infradead.org,
 mhocko@kernel.org, ard.biesheuvel@linaro.org, mark.rutland@arm.com,
 will.deacon@arm.com, catalin.marinas@arm.com, sam@ravnborg.org,
 mgorman@techsingularity.net, akpm@linux-foundation.org,
 steven.sistare@oracle.com, daniel.m.jordan@oracle.com, bob.picco@oracle.com
References: <20171013173214.27300-1-pasha.tatashin@oracle.com>
 <20171013173214.27300-8-pasha.tatashin@oracle.com>
 <f4540f92-2229-53f5-ee74-fe160bedc873@virtuozzo.com>
 <6fd8291b-b3f5-46c1-2650-98a775e37fa0@oracle.com>
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Message-ID: <56120ddc-e03e-dbac-50c4-adb2287ec407@gmail.com>
Date: Wed, 18 Oct 2017 20:20:27 +0300
MIME-Version: 1.0
In-Reply-To: <6fd8291b-b3f5-46c1-2650-98a775e37fa0@oracle.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/18/2017 08:14 PM, Pavel Tatashin wrote:
> Thank you Andrey, I will test this patch. Should it go on top or replace the existing patch in mm-tree? ARM and x86 should be done the same either both as follow-ups or both replace.
> 

 It's a replacement of your patch.


> Pavel
> 
> -- 
> To unsubscribe, send a message with 'unsubscribe linux-mm' in
> the body to majordomo@kvack.org.  For more info on Linux MM,
> see: http://www.linux-mm.org/ .
> Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
