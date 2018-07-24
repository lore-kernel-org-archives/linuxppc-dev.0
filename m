Return-Path: <rdunlap@infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1231::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41ZrRF2RSJzDrGC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jul 2018 07:02:46 +1000 (AEST)
Subject: Re: [PATCH 1/4] treewide: convert ISO_8859-1 text comments to utf-8
To: Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Joe Perches <joe@perches.com>, Samuel Ortiz <sameo@linux.intel.com>,
 "David S. Miller" <davem@davemloft.net>, Rob Herring <robh+dt@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Jonathan Cameron <jic23@kernel.org>,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-iio@vger.kernel.org,
 linux-pm@vger.kernel.org, lvs-devel@vger.kernel.org,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org
References: <20180724111600.4158975-1-arnd@arndb.de>
 <20180724140010.e24a9964fd340afe2d98a994@linux-foundation.org>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d5cf9579-5d61-dafc-5109-b86bfca07dce@infradead.org>
Date: Tue, 24 Jul 2018 14:02:30 -0700
MIME-Version: 1.0
In-Reply-To: <20180724140010.e24a9964fd340afe2d98a994@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/24/2018 02:00 PM, Andrew Morton wrote:
> On Tue, 24 Jul 2018 13:13:25 +0200 Arnd Bergmann <arnd@arndb.de> wrote:
> 
>> Almost all files in the kernel are either plain text or UTF-8
>> encoded. A couple however are ISO_8859-1, usually just a few
>> characters in a C comments, for historic reasons.
>>
>> This converts them all to UTF-8 for consistency.
> 
> Was "consistency" the only rationale?  The discussion is now outside my
> memory horizon but I thought there were other reasons.

kconfig tools prefer ASCII or utf-8.

email tools probably likewise.

user sanity?

> Will we be getting a checkpatch rule to keep things this way?



-- 
~Randy
