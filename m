Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 97FE01A0D79
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 15:54:33 +1100 (AEDT)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Thu, 15 Jan 2015 14:54:33 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 37AAA2CE8040
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 15:54:31 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0F4sU4D36700292
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 15:54:31 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0F4sUOw002089
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 15:54:30 +1100
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: Ryan Grimm <grimm@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/3] CXL: Add image control to sysfs
In-reply-to: <1421296950-sup-6378@delenn.ozlabs.ibm.com>
References: <1421290601-3293-1-git-send-email-grimm@linux.vnet.ibm.com>
 <1421295393-sup-926@delenn.ozlabs.ibm.com>
 <1421296950-sup-6378@delenn.ozlabs.ibm.com>
Date: Thu, 15 Jan 2015 15:54:30 +1100
Message-Id: <1421297600-sup-3509@delenn.ozlabs.ibm.com>
Cc: mikey <mikey@neuling.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> While I think of it - if we change this on boot we should also change
> reset_image_select to match the currently loaded image. e.g. if
> reset_loads_image has defaulted to off and reset_image_select has
> defaulted to factory, but the user image has been loaded - that way we
> avoid unexpectedly switching to factory if the card gets reset.

Nevermind - I see you have done exactly this in patch 3 :-)

-Ian
