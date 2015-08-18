Return-Path: <imunsie@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 570551A0151
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Aug 2015 09:53:12 +1000 (AEST)
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1FDB7140562
 for <linuxppc-dev@ozlabs.org>; Wed, 19 Aug 2015 09:53:11 +1000 (AEST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <imunsie@au1.ibm.com>;
 Wed, 19 Aug 2015 09:53:11 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 255532CE802D
 for <linuxppc-dev@ozlabs.org>; Wed, 19 Aug 2015 09:53:07 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7INqwGI17301564
 for <linuxppc-dev@ozlabs.org>; Wed, 19 Aug 2015 09:53:06 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7INqYbl028476
 for <linuxppc-dev@ozlabs.org>; Wed, 19 Aug 2015 09:52:34 +1000
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, mikey <mikey@neuling.org>,
 dja <dja@axtens.net>
Subject: Re: [PATCH V2] cxl: Allow release of contexts which have been OPENED
 but not STARTED
In-reply-to: <1439940438-3585-1-git-send-email-andrew.donnellan@au1.ibm.com>
References: <1439940438-3585-1-git-send-email-andrew.donnellan@au1.ibm.com>
Date: Wed, 19 Aug 2015 09:52:05 +1000
Message-Id: <1439941913-sup-4288@delenn.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Acked-by: Ian Munsie <imunsie@au1.ibm.com>
