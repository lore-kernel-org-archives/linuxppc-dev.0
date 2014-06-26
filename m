Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F286F1A0008
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jun 2014 18:21:08 +1000 (EST)
Message-ID: <1403770867.18572.6.camel@concordia>
Subject: Re: [PATCH 1/1] selftests/powerpc: fix TARGETS in powerpc selftests
 makefile
From: Michael Ellerman <mpe@ellerman.id.au>
To: Sam Bobroff <sam.bobroff@au1.ibm.com>
Date: Thu, 26 Jun 2014 18:21:07 +1000
In-Reply-To: <cf202ebfe8a42e3f84646e7c2a4bfd6a7e6195bc.1403673509.git.sam.bobroff@au1.ibm.com>
References: <cf202ebfe8a42e3f84646e7c2a4bfd6a7e6195bc.1403673509.git.sam.bobroff@au1.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-06-25 at 15:18 +1000, Sam Bobroff wrote:
> This patch changes the name of a make variable (TARGETS) to prevent it
> from colliding with a value set by the user on the command line (as
> they are recommended to do by tools/testing/selftests/README.txt).
> 
> Before this patch, "make -C tools/testing/selftests TARGETS=powerpc"
> would fail.
> 
> Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
