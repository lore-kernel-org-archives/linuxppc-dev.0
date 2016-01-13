Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5D1B81A0907
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jan 2016 09:53:31 +1100 (AEDT)
Message-ID: <1452725611.14028.0.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc: Wire up copy_file_range() syscall
From: Michael Ellerman <mpe@ellerman.id.au>
To: Chandan Rajendra <chandan@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: chandan@mykolab.com
Date: Thu, 14 Jan 2016 09:53:31 +1100
In-Reply-To: <1452703822-29844-1-git-send-email-chandan@linux.vnet.ibm.com>
References: <1452703822-29844-1-git-send-email-chandan@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-01-13 at 22:20 +0530, Chandan Rajendra wrote:

> Test runs on a ppc64 BE guest succeeded.

Were the tests built 64-bit or 32-bit?

cheers
