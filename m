Return-Path: <npiggin@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t8WD10MgDzDvPl
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Nov 2016 14:48:49 +1100 (AEDT)
Received: from mail-pf0-x232.google.com (mail-pf0-x232.google.com
 [IPv6:2607:f8b0:400e:c00::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3t8WD02c3zz9tl4
 for <linuxppc-dev@ozlabs.org>; Thu,  3 Nov 2016 14:48:48 +1100 (AEDT)
Received: by mail-pf0-x232.google.com with SMTP id n85so23449720pfi.1
 for <linuxppc-dev@ozlabs.org>; Wed, 02 Nov 2016 20:48:48 -0700 (PDT)
Date: Thu, 3 Nov 2016 14:48:39 +1100
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc/configs: Turn on PPC crypto implementations in
 the server defconfigs
Message-ID: <20161103144839.39bec5de@roar.ozlabs.ibm.com>
In-Reply-To: <1478081177-7333-1-git-send-email-mpe@ellerman.id.au>
References: <1478081177-7333-1-git-send-email-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed,  2 Nov 2016 21:06:17 +1100
Michael Ellerman <mpe@ellerman.id.au> wrote:

> These are the PPC optimised versions of various crypto algorithms, so we
> should turn them on by default to get test coverage.

Looks good, thanks for that.
