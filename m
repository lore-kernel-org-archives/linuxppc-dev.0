Return-Path: <sergey.senozhatsky.work@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xz5WM1KrrzDr5G
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Sep 2017 18:00:30 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id j16so237433pga.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Sep 2017 01:00:30 -0700 (PDT)
Date: Fri, 22 Sep 2017 17:00:23 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Santosh Sivaraj <santosh@fossix.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 James Bottomley <jejb@parisc-linux.org>,
 Helge Deller <deller@gmx.de>, Petr Mladek <pmladek@suse.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Jessica Yu <jeyu@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH v2 0/7] printk/ia64/ppc64/parisc64: let's deprecate
 %pF/%pf printk specifiers
Message-ID: <20170922080023.GA599@jagdpanzerIV.localdomain>
References: <20170920162910.32053-1-sergey.senozhatsky@gmail.com>
 <20170922053404.3zpfpwetabjut2er@santosiv.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170922053404.3zpfpwetabjut2er@santosiv.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On (09/22/17 11:04), Santosh Sivaraj wrote:
[..]
> > *** A BIG NOTE ***
> >         I don't own ia64/ppc64/parisc64 hardware, so the patches are not
> >         tested. Sorry about that!
> 
> Tested patch series on ppc64 sucessfully.
> 
> You may add tested by to the series.
> 
> Tested-by: Santosh Sivaraj <santosh@fossix.org>


thanks!

	-ss
