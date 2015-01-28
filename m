Return-Path: <imunsie@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6717B1A03D7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jan 2015 15:03:00 +1100 (AEDT)
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 426FF140281
 for <linuxppc-dev@ozlabs.org>; Wed, 28 Jan 2015 15:03:00 +1100 (AEDT)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <imunsie@au1.ibm.com>;
 Wed, 28 Jan 2015 14:02:59 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id D14E9357804C
 for <linuxppc-dev@ozlabs.org>; Wed, 28 Jan 2015 15:02:56 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0S42uw742991690
 for <linuxppc-dev@ozlabs.org>; Wed, 28 Jan 2015 15:02:56 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0S42tHm023408
 for <linuxppc-dev@ozlabs.org>; Wed, 28 Jan 2015 15:02:55 +1100
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: mpe <mpe@ellerman.id.au>
Subject: Re: [PATCH] CXL: Fix device_node reference counting
In-reply-to: <1420609278-15338-1-git-send-email-imunsie@au.ibm.com>
References: <1420609278-15338-1-git-send-email-imunsie@au.ibm.com>
Date: Wed, 28 Jan 2015 15:02:54 +1100
Message-Id: <1422417621-sup-4057@delenn.ozlabs.ibm.com>
Cc: Ryan Grimm <grimm@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Excerpts from Ian Munsie's message of 2015-01-07 16:41:18 +1100:
> From: Ryan Grimm <grimm@linux.vnet.ibm.com>
> 
> When unbinding and rebinding the driver on a system with a card in PHB0, this
> error condition is reached after a few attempts:

Hey mpe,

I just wanted to check the status of this one? I can't see it in your
tree and wanted to make sure you didn't simply miss it.

Cheers,
-Ian
