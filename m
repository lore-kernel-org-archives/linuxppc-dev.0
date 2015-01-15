Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5BEFD1A0CDC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 16:44:42 +1100 (AEDT)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Thu, 15 Jan 2015 15:44:41 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id AD25E357804F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 16:44:38 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0F5icih39649440
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 16:44:38 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0F5ibHN013335
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 16:44:38 +1100
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 1/3] CXL: Add image control to sysfs
In-reply-to: <1421298437.11409.4.camel@ellerman.id.au>
References: <1421290601-3293-1-git-send-email-grimm@linux.vnet.ibm.com>
 <1421295393-sup-926@delenn.ozlabs.ibm.com>
 <1421298437.11409.4.camel@ellerman.id.au>
Date: Thu, 15 Jan 2015 16:44:37 +1100
Message-Id: <1421300645-sup-3117@delenn.ozlabs.ibm.com>
Cc: Ryan Grimm <grimm@linux.vnet.ibm.com>, mikey <mikey@neuling.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Excerpts from Michael Ellerman's message of 2015-01-15 16:07:17 +1100:
> > Of the two names I'd probably go with reset_image_select.
> 
> Three words, all can be verbs, two can be nouns, it's not too clear.
> 
> Maybe "load_image_on_perst" ?

Works for me :)

Cheers,
-Ian
