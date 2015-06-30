Return-Path: <joseph_myers@mentor.com>
Received: from relay1.mentorg.com (relay1.mentorg.com [192.94.38.131])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 292FC1A1024
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jun 2015 20:48:55 +1000 (AEST)
Date: Tue, 30 Jun 2015 10:48:49 +0000
From: Joseph Myers <joseph@codesourcery.com>
To: Michael Ellerman <mpe@ellerman.id.au>
CC: <linux-kernel@vger.kernel.org>, <linux-alpha@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-s390@vger.kernel.org>,
 <linux-sh@vger.kernel.org>, <sparclinux@vger.kernel.org>
Subject: Re: [PATCH RESEND] Update kernel math-emu code from current glibc
 soft-fp
In-Reply-To: <1435634913.24866.1.camel@ellerman.id.au>
Message-ID: <alpine.DEB.2.10.1506301042250.2339@digraph.polyomino.org.uk>
References: <alpine.DEB.2.10.1505192206580.28384@digraph.polyomino.org.uk>
 <alpine.DEB.2.10.1506221321340.27145@digraph.polyomino.org.uk>
 <1435634913.24866.1.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 30 Jun 2015, Michael Ellerman wrote:

> Is there some way you can imagine of splitting this up into smaller chunks, so
> that different arches can merge the pieces separately?

Well, it could be split as:

1. Rename include/math-emu to math-emu-old and update architectures for 
the renaming (mechanically).

2. Add new include/math-emu.

3,4,5,6,7. Move each architecture from math-emu-old to math-emu.

8. Remove math-emu-old.

You still have patch 1 affecting all five architectures, but with the 
per-architecture changes being much simpler.

-- 
Joseph S. Myers
joseph@codesourcery.com
