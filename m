Return-Path: <chris.friesen@genband.com>
Received: from exprod7og125.obsmtp.com (exprod7og125.obsmtp.com [64.18.2.28])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id CA0F42C00C0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Apr 2013 09:21:53 +1000 (EST)
Message-ID: <5167457E.1050205@genband.com>
Date: Thu, 11 Apr 2013 17:21:34 -0600
From: Chris Friesen <chris.friesen@genband.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: questions on CONFIG_PPC_ADV_DEBUG_REGS, DBCR0_BRT,
 and DBCR0_ACTIVE_EVENTS
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

Sorry for the bunch of emails, I'm working on some new stuff and running 
into issues.

For CONFIG_BOOKE it appears that DBCR0_ACTIVE_EVENTS includes DBCR0_ICMP 
but not DBCR0_BRT.  Is that just because none of the code paths 
currently using DBCR0_ACTIVE_EVENTS need to check DBCR0_BT?

Also, in sys_debug_setcontext() why does SIG_DBG_BRANCH_TRACING return 
-EINVAL if CONFIG_PPC_ADV_DEBUG_REGS is set?  Would it not be possible 
to use DBCR0_BRT?

Thanks,
Chris

-- 

Chris Friesen
Software Designer

500 Palladium Drive, Suite 2100
Ottawa, Ontario K2N 1C2, Canada
www.genband.com
office:+1.343.883.2717
chris.friesen@genband.com
