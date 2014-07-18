Return-Path: <htejun@gmail.com>
Received: from mail-qg0-x22c.google.com (mail-qg0-x22c.google.com
 [IPv6:2607:f8b0:400d:c04::22c])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 026071A07EA
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Jul 2014 04:01:16 +1000 (EST)
Received: by mail-qg0-f44.google.com with SMTP id e89so3536230qgf.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jul 2014 11:01:14 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 18 Jul 2014 14:01:10 -0400
From: Tejun Heo <tj@kernel.org>
To: Nish Aravamudan <nish.aravamudan@gmail.com>
Subject: Re: [RFC 0/2] Memoryless nodes and kworker
Message-ID: <20140718180110.GD13012@htj.dyndns.org>
References: <20140717230923.GA32660@linux.vnet.ibm.com>
 <20140718112039.GA8383@htj.dyndns.org>
 <CAOhV88PyBK3WxDjG1H0hUbRhRYzPOzV8eim5DuOcgObe-FtFYg@mail.gmail.com>
 <20140718180008.GC13012@htj.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140718180008.GC13012@htj.dyndns.org>
Cc: Fenghua Yu <fenghua.yu@intel.com>, Tony Luck <tony.luck@intel.com>,
 linux-ia64@vger.kernel.org, Nishanth Aravamudan <nacc@linux.vnet.ibm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linux Memory Management List <linux-mm@kvack.org>,
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 linuxppc-dev@lists.ozlabs.org, Jiang Liu <jiang.liu@linux.intel.com>,
 Wanpeng Li <liwanp@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 18, 2014 at 02:00:08PM -0400, Tejun Heo wrote:
> This isn't a huge issue but it shows that this is the wrong layer to
> deal with this issue.  Let the allocators express where they are.
                                 ^
				 allocator users
> Choosing and falling back belong to the memory allocator.  That's the
> only place which has all the information that's necessary and those
> details must be contained there.  Please don't leak it to memory
> allocator users.

-- 
tejun
