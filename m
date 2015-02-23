Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 001E91A0BE9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Feb 2015 14:41:09 +1100 (AEDT)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Mon, 23 Feb 2015 13:41:08 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id DEB592BB0047
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Feb 2015 14:41:05 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1N3evEu33554586
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Feb 2015 14:41:05 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1N3eWOM022130
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Feb 2015 14:40:32 +1100
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH] cxl: Remove useless precision specifiers
In-reply-to: <1424438782-31545-1-git-send-email-linux@rasmusvillemoes.dk>
References: <1424438782-31545-1-git-send-email-linux@rasmusvillemoes.dk>
Date: Mon, 23 Feb 2015 14:40:08 +1100
Message-Id: <1424662685-sup-6648@delenn.ozlabs.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Excerpts from Rasmus Villemoes's message of 2015-02-21 00:26:22 +1100:
> C99 says that a precision given as simply '.' with no following digits
> or * should be interpreted as 0. The kernel's printf implementation,
> however, treats this case as if the precision was omitted. C99 also
> says that if both the precision and value are 0, no digits should be
> printed. Even if the kernel followed C99 to the letter, I don't think
> that would be particularly useful in these cases, so just remove the
> precision specifiers.

Nice catch Rasmus, but I think a better patch would be one that adds the
missing precision (%.16llx).

Cheers,
-Ian
