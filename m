Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3922C1A0E02
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jan 2015 02:33:25 +1100 (AEDT)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 22 Jan 2015 01:33:23 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 8496C3578048
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jan 2015 02:33:21 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0LFXL0446399624
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jan 2015 02:33:21 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0LFXKRG008407
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jan 2015 02:33:20 +1100
Date: Wed, 21 Jan 2015 21:03:03 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, mpe@ellerman.id.au
Subject: Re: [RFC PATCH 0/8] Fix perf probe issues on powerpc
Message-ID: <20150121153303.GM2245@naverao1-tp.ibm.com>
References: <cover.1418146300.git.naveen.n.rao@linux.vnet.ibm.com>
 <20150121125142.GC3420@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150121125142.GC3420@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2015/01/21 09:51AM, Arnaldo Carvalho de Melo wrote:
> Em Tue, Dec 09, 2014 at 11:03:58PM +0530, Naveen N. Rao escreveu:
> > This patchset fixes various issues with perf probe on powerpc
> > across ABIv1 and ABIv2:
> > - in the presence of DWARF debug-info,
> > - in the absence of DWARF, but with the symbol table, and
> > - in the absence of debug-info, but with kallsyms.
> > 
> > Applies cleanly on v3.18 and on -tip with minor changes to patch 6.
> > Tested on ppc64 BE and LE.
> > 
> > - Naveen
> > 
> > Naveen N. Rao (8):
> >   kprobes: Fix kallsyms lookup across powerpc ABIv1 and ABIv2
> >   perf probe powerpc: Fix symbol fixup issues due to ELF type
> >   perf probe: Improve detection of file/function name in the probe
> >     pattern
> >   perf probe powerpc: Handle powerpc dot symbols
> >   perf probe powerpc: Allow matching against dot symbols
> >   perf tools powerpc: Fix PPC64 ELF ABIv2 symbol decoding
> >   perf probe powerpc: Use DWARF info only if necessary
> >   perf probe powerpc: Fixup function entry if using kallsyms lookup
> 
> Naveen,
> 
> 	I saw several comments by Michael, have you tried to address
> those comments and have you resubmitted this patchset?

Hi Arnaldo,
Yes. Please find v2 of this patchset here:
http://thread.gmane.org/gmane.linux.kernel/1851128

I request you to kindly take another look and let me know if you have 
further questions.

Michael,
Looking forward to your feedback.


Thanks!
- Naveen
