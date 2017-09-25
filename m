Return-Path: <deller@gmx.de>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y19Tp0jJ9zDsN9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Sep 2017 03:06:21 +1000 (AEST)
Subject: Re: [RFC][PATCH v2 0/7] printk/ia64/ppc64/parisc64: let's deprecate
 %pF/%pf printk specifiers
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: "Luck, Tony" <tony.luck@intel.com>, Santosh Sivaraj <santosh@fossix.org>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 "Yu, Fenghua" <fenghua.yu@intel.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 James Bottomley <jejb@parisc-linux.org>, Petr Mladek <pmladek@suse.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Andrew Morton <akpm@linux-foundation.org>, Jessica Yu <jeyu@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20170920162910.32053-1-sergey.senozhatsky@gmail.com>
 <20170922053404.3zpfpwetabjut2er@santosiv.in.ibm.com>
 <20170922080023.GA599@jagdpanzerIV.localdomain>
 <3908561D78D1C84285E8C5FCA982C28F61381992@ORSMSX114.amr.corp.intel.com>
 <20170925070542.GA387@jagdpanzerIV.localdomain>
 <3908561D78D1C84285E8C5FCA982C28F61384020@ORSMSX114.amr.corp.intel.com>
From: Helge Deller <deller@gmx.de>
Message-ID: <81cfc7bc-9d3b-97c4-b9f6-a740d40231b8@gmx.de>
Date: Mon, 25 Sep 2017 19:05:00 +0200
MIME-Version: 1.0
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F61384020@ORSMSX114.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 25.09.2017 18:29, Luck, Tony wrote:
>> speaking of upstream, any objections if this patch set will go through
>> the printk tree, in one piece?

Fine with me too.

Helge
