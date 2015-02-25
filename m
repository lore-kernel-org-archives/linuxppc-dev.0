Return-Path: <imunsie@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AA6571A0013
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Feb 2015 15:42:00 +1100 (AEDT)
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8261B1400F1
 for <linuxppc-dev@ozlabs.org>; Wed, 25 Feb 2015 15:42:00 +1100 (AEDT)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <imunsie@au1.ibm.com>;
 Wed, 25 Feb 2015 14:41:59 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id C36772BB0051
 for <linuxppc-dev@ozlabs.org>; Wed, 25 Feb 2015 15:41:54 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1P4fkH836438126
 for <linuxppc-dev@ozlabs.org>; Wed, 25 Feb 2015 15:41:54 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1P4fK8r023259
 for <linuxppc-dev@ozlabs.org>; Wed, 25 Feb 2015 15:41:21 +1100
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/3] cxl: Use image state defaults for reloading FPGA
In-reply-to: <20150225003229.GA10806@kroah.com>
References: <1424665281-25431-1-git-send-email-mpe@ellerman.id.au>
 <20150225003229.GA10806@kroah.com>
Date: Wed, 25 Feb 2015 15:40:56 +1100
Message-Id: <1424839211-sup-7519@delenn.ozlabs.ibm.com>
Cc: grimm <grimm@linux.vnet.ibm.com>, stable <stable@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Excerpts from Greg KH's message of 2015-02-25 11:32:29 +1100:
> What stable kernel(s) are you wanting this series to go into?

Hi Greg,

These three patches are for 3.18 and 3.19.

Cheers,
-Ian
