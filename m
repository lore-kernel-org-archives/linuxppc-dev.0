Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wSH7g1vlRzDqYB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 May 2017 11:40:14 +1000 (AEST)
Received: by mail-pg0-x243.google.com with SMTP id h64so18611954pge.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 May 2017 18:40:14 -0700 (PDT)
Message-ID: <1494985204.30802.4.camel@gmail.com>
Subject: Re: [RFC 2/2] powerpc/kprobes: Move kprobes over to patch_instruction
From: Balbir Singh <bsingharora@gmail.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
 ananth@linux.vnet.ibm.com
Date: Wed, 17 May 2017 11:40:04 +1000
In-Reply-To: <20170516133532.GA19390@naverao1-tp.localdomain>
References: <20170516034913.21163-1-bsingharora@gmail.com>
 <20170516034913.21163-3-bsingharora@gmail.com>
 <20170516133532.GA19390@naverao1-tp.localdomain>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-05-16 at 19:05 +0530, Naveen N. Rao wrote:
> On 2017/05/16 01:49PM, Balbir Singh wrote:
> > arch_arm/disarm_probe use direct assignment for copying
> > instructions, replace them with patch_instruction
> 
> Thanks for doing this!
> 
> We will also have to convert optprobes and ftrace to use 
> patch_instruction, but that can be done once the basic infrastructure is 
> in.
>

I think these patches can go in without even patch 1. I looked quickly at
optprobes and ftrace and thought they were already using patch_instruction
(ftrace_modify_code() and arch_optimize_kprobes()), are there other paths
I missed?

Balbir Singh
 
