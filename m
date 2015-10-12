Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A17A71A027D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2015 22:21:21 +1100 (AEDT)
In-Reply-To: <1444330858-5508-1-git-send-email-colin.king@canonical.com>
To: Colin King <colin.king@canonical.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: powerpc/pseries/hvcserver: don't memset pi_buff if it is null
Message-Id: <20151012112121.8623F14029E@ozlabs.org>
Date: Mon, 12 Oct 2015 22:21:21 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-08-10 at 19:00:58 UTC, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> pi_buff is being memset before it is sanity checked. Move the
> memset after the null pi_buff sanity check to avoid an oops.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/c13e1c05b22b504bf0d72fc7

cheers
