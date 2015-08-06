Return-Path: <vbabka@suse.cz>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EBAAC1A009B
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Aug 2015 00:00:45 +1000 (AEST)
Subject: Re: [PATCH V6 2/6] mm: mlock: Add new mlock system call
To: Eric B Munson <emunson@akamai.com>,
 Andrew Morton <akpm@linux-foundation.org>
References: <1438184575-10537-1-git-send-email-emunson@akamai.com>
 <1438184575-10537-3-git-send-email-emunson@akamai.com>
Cc: Michal Hocko <mhocko@suse.cz>, Heiko Carstens
 <heiko.carstens@de.ibm.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>, Guenter Roeck <linux@roeck-us.net>,
 linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 adi-buildroot-devel@lists.sourceforge.net, linux-cris-kernel@axis.com,
 linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 linux-am33-list@redhat.com, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-xtensa@linux-xtensa.org, linux-api@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-mm@kvack.org
From: Vlastimil Babka <vbabka@suse.cz>
Message-ID: <55C36881.8050301@suse.cz>
Date: Thu, 6 Aug 2015 16:00:33 +0200
MIME-Version: 1.0
In-Reply-To: <1438184575-10537-3-git-send-email-emunson@akamai.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/29/2015 05:42 PM, Eric B Munson wrote:
> With the refactored mlock code, introduce a new system call for mlock.
> The new call will allow the user to specify what lock states are being
> added.  mlock2 is trivial at the moment, but a follow on patch will add
> a new mlock state making it useful.
>
> Signed-off-by: Eric B Munson <emunson@akamai.com>
> Cc: Michal Hocko <mhocko@suse.cz>
> Cc: Vlastimil Babka <vbabka@suse.cz>

Acked-by: Vlastimil Babka <vbabka@suse.cz>
