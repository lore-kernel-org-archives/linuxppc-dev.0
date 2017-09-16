Return-Path: <sergey.senozhatsky@gmail.com>
Received: from mail-pf0-x229.google.com (mail-pf0-x229.google.com
 [IPv6:2607:f8b0:400e:c00::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xvVSJ5f6LzDq78
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Sep 2017 21:30:24 +1000 (AEST)
Received: by mail-pf0-x229.google.com with SMTP id r71so2673561pfe.12
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Sep 2017 04:30:24 -0700 (PDT)
Date: Sat, 16 Sep 2017 20:25:35 +0900
From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 "James E . J . Bottomley" <jejb@parisc-linux.org>,
 Helge Deller <deller@gmx.de>, Petr Mladek <pmladek@suse.com>,
 linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 Jessica Yu <jeyu@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 3/5] powerpc64: Add .opd based function descriptor
 dereference
Message-ID: <20170916112535.GA495@tigerII.localdomain>
References: <20170916035347.19705-1-sergey.senozhatsky@gmail.com>
 <20170916035347.19705-4-sergey.senozhatsky@gmail.com>
 <20170916094345.d332z3odceqiyrll@naverao1-tp.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170916094345.d332z3odceqiyrll@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On (09/16/17 15:13), Naveen N. Rao wrote:
[..]
> Would it be simpler to just use kernel_text_address() and dereference 
> everything else? See commit 83e840c770f2c5 ("powerpc64/elfv1: Only 
> dereference function descriptor for non-text symbols") for a related 
> patch.

I had this idea, see

lkml.kernel.org/r/20170908172528.qc2vdtxzqh777k6o@intel.com


	-ss
