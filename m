Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 772601A1628
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Dec 2015 23:24:44 +1100 (AEDT)
Message-ID: <1450355077.8262.0.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc: add va_end()
From: Michael Ellerman <mpe@ellerman.id.au>
To: Russell Currey <ruscur@russell.cc>, Daniel Axtens <dja@axtens.net>,
 linuxppc-dev@ozlabs.org
Date: Thu, 17 Dec 2015 23:24:37 +1100
In-Reply-To: <1450354171.1669.4.camel@russell.cc>
References: <1450341660-31305-1-git-send-email-dja@axtens.net>
 <1450354171.1669.4.camel@russell.cc>
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

On Thu, 2015-12-17 at 23:09 +1100, Russell Currey wrote:
> On Thu, 2015-12-17 at 19:41 +1100, Daniel Axtens wrote:
> > cppcheck picked up that there were a couple of missing va_end()
> > calls in functions using va_start().
> > 
> > Signed-off-by: Daniel Axtens <dja@axtens.net>
> Hey Daniel,
> 
> It's probably not worth a V2 but I think this could use a commit title that's a
> bit more detailed.  Right now it doesn't really allude to what it fixes or what
> it affects.

Yeah, the change log is OK, but the actual subject is a bit terse.

I changed it to "powerpc: Add missing calls to va_end()".

cheers
