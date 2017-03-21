Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vnW3f6rn7zDqbt
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 22:36:14 +1100 (AEDT)
In-Reply-To: <1488788731-2537-1-git-send-email-me@tobin.cc>
To: "Tobin C. Harding" <me@tobin.cc>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 "Tobin C. Harding" <me@tobin.cc>
Subject: Re: powerpc: fix sparse warning, include kernel header
Message-Id: <3vnW3f5czwz9s84@ozlabs.org>
Date: Tue, 21 Mar 2017 22:36:14 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-03-06 at 08:25:31 UTC, "Tobin C. Harding" wrote:
> Spares emits two symbol not declared warnings. The two functions in
> question are declared already in a kernel header.
> 
> Add include directive to include kernel header.
> 
> Signed-off-by: Tobin C. Harding <me@tobin.cc>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/1fc439c81312cd27aed553964c0d9d

cheers
