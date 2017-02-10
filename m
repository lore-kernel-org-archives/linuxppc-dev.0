Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vKTW81M5FzDqBr
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Feb 2017 20:03:16 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id 75so2689586pgf.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Feb 2017 01:03:16 -0800 (PST)
From: Balbir Singh <bsingharora@gmail.com>
Date: Fri, 10 Feb 2017 14:33:07 +0530
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Balbir Singh <bsingharora@gmail.com>,
 Douglas Miller <dougmill@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/1] powerpc/xmon: Dump memory in native endian format.
Message-ID: <20170210090307.GB25662@dhcp-9-109-222-205.in.ibm.com>
References: <1486474844-9872-1-git-send-email-dougmill@linux.vnet.ibm.com>
 <20170208082254.GC17068@localhost.localdomain>
 <87fujp9h2o.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87fujp9h2o.fsf@concordia.ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 08, 2017 at 08:18:07PM +1100, Michael Ellerman wrote:
> Balbir Singh <bsingharora@gmail.com> writes:
> 
> >> +			printf("Faulted reading %d bytes from 0x"REG"\n", 16, addr);
> >
> > We have a method of printing a special character for faults.
> > Please see fault_chars[]
> 
> Yeah but it's not worth the complication IMO. In practice you usually
> fault on everything you tried to print or nothing.

Fair enough, I was worried about consistency across commands and its
quite possible that on crossing a page boundary we see inconsistent
output. I'm OK with it, one can always retry the command with smaller
number of bytes.

Balbir Singh.
