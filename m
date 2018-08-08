Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41ltxW3CLnzDqk8
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Aug 2018 00:26:55 +1000 (AEST)
In-Reply-To: <1533291638-22224-1-git-send-email-sparth1292@gmail.com>
To: Parth Y Shah <sparth1292@gmail.com>, fbarrat@linux.vnet.ibm.com,
 andrew.donnellan@au1.ibm.com, arnd@arndb.de, gregkh@linuxfoundation.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Parth Y Shah <sparth1292@gmail.com>
Subject: Re: misc: cxl: changed asterisk position
Message-Id: <41ltxQ3Q8Mz9s9F@ozlabs.org>
Date: Thu,  9 Aug 2018 00:26:34 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2018-08-03 at 10:20:38 UTC, Parth Y Shah wrote:
> Resolved <"foo* bar" should be "foo *bar"> error
> 
> Signed-off-by: Parth Y Shah <sparth1292@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/a0ac3687fb404d59296ecba4642071

cheers
