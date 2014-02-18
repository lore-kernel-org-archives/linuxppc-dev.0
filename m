Return-Path: <benh@au1.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3B2BB2C00D5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Feb 2014 10:47:26 +1100 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Wed, 19 Feb 2014 09:47:25 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 3B65B2BB0052
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Feb 2014 10:47:23 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1INRcxF62128286
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Feb 2014 10:27:38 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1INlMBr030787
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Feb 2014 10:47:22 +1100
Message-ID: <1392767239.25616.11.camel@pasglop>
Subject: Re: [PATCH v3 3/3] powerpc/pseries: Report in kernel device tree
 update to drmgr
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: Tyrel Datwyler <turtle.in.the.kernel@gmail.com>
Date: Wed, 19 Feb 2014 10:47:19 +1100
In-Reply-To: <5303EC9E.7070507@gmail.com>
References: <1391212692-16217-1-git-send-email-tyreld@linux.vnet.ibm.com>
 <1391212692-16217-4-git-send-email-tyreld@linux.vnet.ibm.com>
 <1392596560.24061.12.camel@pasglop> <5303EC9E.7070507@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: nfont@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-02-18 at 15:28 -0800, Tyrel Datwyler wrote:
> In this case we get a double update which I clearly neglected to
> mention
> in the patch. The first patch in this series actually removes an
> unnecessary double update from the existing kernel implementation. The
> same information is returned by the update-nodes/properties call the
> second time around and aside from being a waste of a few cycles is
> harmless.

Thanks. Can you resend the patches with updated descriptions ? I will
try to send them to Linus by end of week.

Cheers,
Ben.
