Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 993701A0A45
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2015 13:06:44 +1100 (AEDT)
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Wed, 25 Nov 2015 12:06:42 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id AC6312CE8058
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2015 13:06:40 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tAP26Y1N36700400
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2015 13:06:42 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tAP26762002105
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2015 13:06:08 +1100
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Frank Haverkamp <HAVERKAM@de.ibm.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
Subject: Re: [PATCH] cxl: Fix DSI misses when the context owning task exits
In-reply-to: <1448362578-32456-1-git-send-email-vaibhav@linux.vnet.ibm.com>
References: <1448362578-32456-1-git-send-email-vaibhav@linux.vnet.ibm.com>
Date: Wed, 25 Nov 2015 13:05:39 +1100
Message-Id: <1448417024-sup-3306@delenn.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thanks Vaibhav! This should definitely help people avoid pain in this
corner case :)

Acked-by: Ian Munsie <imunsie@au1.ibm.com>
