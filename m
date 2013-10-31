Return-Path: <gang.chen@asianux.com>
Received: from intranet.asianux.com (intranet.asianux.com [58.214.24.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 13E4D2C03C4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Oct 2013 13:49:25 +1100 (EST)
Message-ID: <5271BDFD.2050205@asianux.com>
Date: Thu, 31 Oct 2013 10:18:37 +0800
From: Chen Gang <gang.chen@asianux.com>
MIME-Version: 1.0
To: srinivas.pandruvada@linux.intel.com, jacob.jun.pan@linux.intel.com,
 "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: [Suggestion] drivers: powercap: 'dev_attrs' has already removed from
 'struct class'
Content-Type: text/plain; charset=windows-1252
Cc: Greg KH <gregkh@linuxfoundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Maintainers

It is removed by "bcc8edb driver core: remove dev_attrs from struct
class" in Oct 5 2013. But "75d2364 PowerCap: Add class driver" still
use it in Oct 11 2013.

The related error (for powerpc with allmodconfig):

  CC      drivers/powercap/powercap_sys.o
drivers/powercap/powercap_sys.c:484:2: error: unknown field ‘dev_attrs’ specified in initializer
drivers/powercap/powercap_sys.c:484:2: warning: initialization from incompatible pointer type [enabled by default]
drivers/powercap/powercap_sys.c:484:2: warning: (near initialization for ‘powercap_class.suspend’) [enabled by default]


Please give a check thanks.

Thanks.
-- 
Chen Gang
