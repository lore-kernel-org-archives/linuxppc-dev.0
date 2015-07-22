Return-Path: <imunsie@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E83171A1A35
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2015 10:37:50 +1000 (AEST)
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A85BD1402D7
 for <linuxppc-dev@ozlabs.org>; Wed, 22 Jul 2015 10:37:50 +1000 (AEST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <imunsie@au1.ibm.com>;
 Wed, 22 Jul 2015 10:37:49 +1000
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: Anton Blanchard <anton@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@au1.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Michael Neuling <michael.neuling@au1.ibm.com>,
 "sonal.santan" <sonal.santan@xilinx.com>, Jeremy Kerr <jk@ozlabs.org>,
 Samuel Mendoza-Jonas <sam.mj@au1.ibm.com>
Subject: Re: [PATCH] Fix crash due to processing "memory-controller" nodes as
 "memory"
In-reply-to: <20150722091844.114ea023@kryten>
References: <1437380450-25555-1-git-send-email-imunsie@au.ibm.com>
 <20150721124554.332dd228@kryten> <1437447984.30722.3.camel@ellerman.id.au>
 <20150722091844.114ea023@kryten>
Date: Wed, 22 Jul 2015 10:36:47 +1000
Message-Id: <1437525346-sup-7472@delenn.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Excerpts from Anton Blanchard's message of 2015-07-22 09:18:44 +1000:
> Hi,
> 
> > > Nice catch! I wonder if we should be checking for device_type
> > > "memory". Ben?
> > 
> > Yes. That's what Linux does.
> 
> Ian: I made that change, and slightly modified your commit message.
> Look ok?

Looks good to me :)

Cheers,
-Ian
