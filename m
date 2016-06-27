Return-Path: <colin.king@canonical.com>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rdQQc1fNWzDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 20:38:47 +1000 (AEST)
Subject: Re: powerpc/fadump: trivial fix of spelling mistake, clean up message
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Jiri Kosina <trivial@kernel.org>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
References: <3rcf3g63Wnz9s5Q@ozlabs.org>
Cc: linux-kernel@vger.kernel.org
From: Colin Ian King <colin.king@canonical.com>
Message-ID: <5771021E.3050305@canonical.com>
Date: Mon, 27 Jun 2016 11:38:22 +0100
MIME-Version: 1.0
In-Reply-To: <3rcf3g63Wnz9s5Q@ozlabs.org>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 26/06/16 05:19, Michael Ellerman wrote:
> On Fri, 2016-24-06 at 17:43:00 UTC, Colin King wrote:
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> trivial fix to spelling mistake "rgistration" and minor clean up
>> of the printk error message
> 
> Can you also:
>  - use pr_err()
>  - unsplit the message, ie. keep the string all on one line.

I can unsplit the string, but checkpatch will complain about that, so
I'm not sure if that's preferred or not.

WARNING: line over 80 characters

Colin
