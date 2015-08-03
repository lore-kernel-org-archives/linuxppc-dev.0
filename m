Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 63EC71A1D5B
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Aug 2015 11:37:09 +1000 (AEST)
Message-ID: <1438565822.8863.2.camel@ellerman.id.au>
Subject: Re: [PATCH] cxl: Fix ambiguous else warnings
From: Michael Ellerman <mpe@ellerman.id.au>
To: Daniel Axtens <dja@axtens.net>
Cc: Andreas Schwab <schwab@linux-m68k.org>, Thomas Huth <thuth@redhat.com>,
 linuxppc-dev@ozlabs.org, mikey@neuling.org, imunsie@au.ibm.com
Date: Mon, 03 Aug 2015 11:37:02 +1000
In-Reply-To: <1438562877.31010.16.camel@axtens.net>
References: <1438324508-30341-1-git-send-email-dja__13473.5064967119$1438324749$gmane$org@axtens.net>
 <87wpxg3cvv.fsf@igel.home> <1438562207.31010.14.camel@axtens.net>
 <1438562604.8863.1.camel@ellerman.id.au>
 <1438562877.31010.16.camel@axtens.net>
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

On Mon, 2015-08-03 at 10:47 +1000, Daniel Axtens wrote:
> > This should be a static inline, not a #define.
> > 
> I'm changing them to static inlines at the moment. Would you prefer a v3
> of the EEH patches, or a new patch on top?

Without looking closer I think a v3.

ie. before you change the logic of the macro to include an if, it should become
a static inline.

cheers
