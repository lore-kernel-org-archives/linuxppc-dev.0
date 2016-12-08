Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tZSwW2RpjzDw6R
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Dec 2016 08:21:31 +1100 (AEDT)
Date: Fri, 9 Dec 2016 08:18:22 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Jia He <hejianet@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org,
 mpe@ellerman.id.au, aneesh.kumar@linux.vnet.ibm.com,
 mikey@neuling.org, cyrilbur@gmail.com, shreyas@linux.vnet.ibm.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: Fix LPCR_VRMASD definition
Message-ID: <20161208211822.GA18411@fergus.ozlabs.ibm.com>
References: <1481167770-7042-1-git-send-email-hejianet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1481167770-7042-1-git-send-email-hejianet@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Dec 08, 2016 at 11:29:30AM +0800, Jia He wrote:
> Fixes: a4b349540a ("powerpc/mm: Cleanup LPCR defines")
> Signed-off-by: Jia He <hejianet@gmail.com>

Acked-by: Paul Mackerras <paulus@ozlabs.org>
