Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qrkT84Ct9zDqgP
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2016 15:19:56 +1000 (AEST)
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Fri, 22 Apr 2016 15:19:55 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id C85E23578053
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2016 15:19:52 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3M5JioN59768870
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2016 15:19:52 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3M5JJQ6022221
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2016 15:19:20 +1000
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: Michael Neuling <mikey@neuling.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Joerg-Stephan Vogt <JSVOGT@de.ibm.com>,
 Frederic Barrat <frederic.barrat@fr.ibm.com>,
 Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 Wolfgang Bolz1 <Wolfgang.Bolz@de.ibm.com>,
 "andrew.donnellan" <andrew.donnellan@au1.ibm.com>,
 Frank Haverkamp <HAVERKAM@de.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 2/2] cxl: Poll for outstanding IRQs when detaching a
 context
In-reply-to: <1461301069-12331-2-git-send-email-mikey@neuling.org>
References: <1461301069-12331-1-git-send-email-mikey@neuling.org>
 <1461301069-12331-2-git-send-email-mikey@neuling.org>
Date: Fri, 22 Apr 2016 15:18:52 +1000
Message-Id: <1461302325-sup-7499@x230.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Acked-by: Ian Munsie <imunsie@au1.ibm.com>
