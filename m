Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1230B1A014C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Feb 2015 15:29:57 +1100 (AEDT)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Tue, 24 Feb 2015 14:29:55 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id D43E42CE8040
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Feb 2015 15:29:51 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1O4ThgM40632406
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Feb 2015 15:29:51 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1O4TI0O004301
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Feb 2015 15:29:18 +1100
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: Joe Perches <joe@perches.com>
Subject: Re: [PATCH v2] cxl: Add explicit precision specifiers
In-reply-to: <1424703585.20944.28.camel@perches.com>
References: <1424662685-sup-6648@delenn.ozlabs.ibm.com>
 <1424688935-6645-1-git-send-email-linux@rasmusvillemoes.dk>
 <1424703585.20944.28.camel@perches.com>
Date: Tue, 24 Feb 2015 15:28:54 +1100
Message-Id: <1424751969-sup-7377@delenn.ozlabs.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Michael Neuling <mikey@neuling.org>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 linux-kernel <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Excerpts from Joe Perches's message of 2015-02-24 01:59:45 +1100:
> On Mon, 2015-02-23 at 11:55 +0100, Rasmus Villemoes wrote:
> > 24 of the %.16llx
> > matches are in drivers/misc/cxl/, so internal consistency wins.
> 
> I think that's more an argument for changing all of the
> cx1 uses to "%016llx".

I would not object if someone submitted a patch that makes this change
across the whole driver.

Cheers,
-Ian
