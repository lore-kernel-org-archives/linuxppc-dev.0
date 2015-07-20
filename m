Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1AD771A094B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2015 18:26:42 +1000 (AEST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Mon, 20 Jul 2015 18:26:41 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id ED1EC2BB003F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2015 18:26:39 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6K8QVkS57409554
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2015 18:26:39 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6K8Q7QT023155
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2015 18:26:07 +1000
Received: from ozlabs.au.ibm.com (ozlabs.au.ibm.com [9.192.253.14])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 t6K8Q7kG022548
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2015 18:26:07 +1000
Received: from localhost (unknown [9.192.254.114])
 (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 2B2EBA01B7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2015 18:25:43 +1000 (AEST)
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] Fix crash due to processing "memory-controller" nodes as
 "memory"
In-reply-to: <1437380450-25555-1-git-send-email-imunsie@au.ibm.com>
References: <1437380450-25555-1-git-send-email-imunsie@au.ibm.com>
Date: Mon, 20 Jul 2015 18:25:43 +1000
Message-Id: <1437380690-sup-3387@delenn.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Whoops - subject line was supposed to say "kexec-lite: ..."

-Ian
