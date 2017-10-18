Return-Path: <pasha.tatashin@oracle.com>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yHJbX40XKzDrPk
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 04:15:19 +1100 (AEDT)
Subject: Re: [PATCH v12 07/11] x86/kasan: add and use kasan_map_populate()
To: Andrey Ryabinin <aryabinin@virtuozzo.com>, linux-kernel@vger.kernel.org,
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
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Message-ID: <6fd8291b-b3f5-46c1-2650-98a775e37fa0@oracle.com>
Date: Wed, 18 Oct 2017 13:14:11 -0400
MIME-Version: 1.0
In-Reply-To: <f4540f92-2229-53f5-ee74-fe160bedc873@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thank you Andrey, I will test this patch. Should it go on top or replace 
the existing patch in mm-tree? ARM and x86 should be done the same 
either both as follow-ups or both replace.

Pavel
