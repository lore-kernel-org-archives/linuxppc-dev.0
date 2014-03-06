Return-Path: <cody@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 802742C00AA
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Mar 2014 11:45:20 +1100 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cody@linux.vnet.ibm.com>;
 Wed, 5 Mar 2014 19:45:18 -0500
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 7961538C803D
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Mar 2014 19:45:14 -0500 (EST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp23032.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s260jE2n8192326
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Mar 2014 00:45:14 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s260jDZu015247
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Mar 2014 19:45:14 -0500
From: Cody P Schafer <cody@linux.vnet.ibm.com>
To: linux-doc@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>,
 Cody P Schafer <cody@linux.vnet.ibm.com>,
 Michael Ellerman <michael@ellerman.id.au>,
 Runzhen Wang <runzhen@linux.vnet.ibm.com>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: [PATCH 0/2] perf: add documentation for sysfs interfaces
Date: Wed,  5 Mar 2014 16:44:13 -0800
Message-Id: <1394066658-16766-1-git-send-email-cody@linux.vnet.ibm.com>
Cc: rob@landley.net, Linux PPC <linuxppc-dev@lists.ozlabs.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Documents <pmu>/event/<event>{,.scale,.units} and then removes the redundant
POWER docs.

Slightly restricts <event> names to avoid API funkyness when we add new
<event>.????? files ('.' forbidden in event names).

The contact is currently lkml, it would be very useful to have a perf
development list to put here instead (acme, feel like making one?).

--

Cody P Schafer (2):
  perf Documentation: sysfs events/ interfaces
  perf Documentation: remove duplicated docs for powerpc cpu specific
    events

 .../testing/sysfs-bus-event_source-devices-events  | 92 +++++++++++-----------
 1 file changed, 47 insertions(+), 45 deletions(-)

-- 
1.9.0
