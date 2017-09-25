Return-Path: <tony.luck@intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y18gg1JVxzDsPg
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Sep 2017 02:29:50 +1000 (AEST)
From: "Luck, Tony" <tony.luck@intel.com>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
CC: Santosh Sivaraj <santosh@fossix.org>, Sergey Senozhatsky
 <sergey.senozhatsky@gmail.com>, "Yu, Fenghua" <fenghua.yu@intel.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, James Bottomley
 <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Petr Mladek
 <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Andrew Morton
 <akpm@linux-foundation.org>, Jessica Yu <jeyu@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC][PATCH v2 0/7] printk/ia64/ppc64/parisc64: let's deprecate
 %pF/%pf printk specifiers
Date: Mon, 25 Sep 2017 16:29:43 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F61384020@ORSMSX114.amr.corp.intel.com>
References: <20170920162910.32053-1-sergey.senozhatsky@gmail.com>
 <20170922053404.3zpfpwetabjut2er@santosiv.in.ibm.com>
 <20170922080023.GA599@jagdpanzerIV.localdomain>
 <3908561D78D1C84285E8C5FCA982C28F61381992@ORSMSX114.amr.corp.intel.com>
 <20170925070542.GA387@jagdpanzerIV.localdomain>
In-Reply-To: <20170925070542.GA387@jagdpanzerIV.localdomain>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> speaking of upstream, any objections if this patch set will go through
> the printk tree, in one piece?

Seems to be a better idea than trying to coordinate pulls from three
separate "arch/"  trees.  Fine with me.

-Tony
