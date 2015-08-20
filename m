Return-Path: <dominik@greysector.net>
Received: from watanuki.greysector.net (watanuki.greysector.net
 [IPv6:2a01:4f8:bc:610::b2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 797981A1D62
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2015 19:46:57 +1000 (AEST)
Received: from mokona.greysector.net (81.obywatelska.supermedia.pl
 [212.180.237.81])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by watanuki.greysector.net (Postfix) with ESMTPS id 86527200FE
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2015 11:46:51 +0200 (CEST)
Received: from mokona.greysector.net (localhost [127.0.0.1])
 by mokona.greysector.net (Postfix) with ESMTP id E9D1B1259
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2015 11:46:50 +0200 (CEST)
Received: from sakura.greysector.net (unknown [192.193.115.36])
 (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mokona.greysector.net (Postfix) with ESMTPSA id 1E958A96
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2015 11:46:49 +0200 (CEST)
Date: Thu, 20 Aug 2015 11:46:44 +0200
From: Dominik 'Rathann' Mierzejewski <dominik@greysector.net>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: error: 'asm' operand has impossible constraints when compiling
 gromacs 5.1 on PPC64 and PPC64LE with VSX SMD
Message-ID: <20150820094644.GA2964@sakura.greysector.net>
References: <20150820073106.GB10057@sakura.greysector.net>
 <20150820092649.GD26407@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150820092649.GD26407@gate.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thursday, 20 August 2015 at 11:26, Segher Boessenkool wrote:
> Hi,
> 
> On Thu, Aug 20, 2015 at 09:31:07AM +0200, Dominik 'Rathann' Mierzejewski wrote:
> > /builddir/build/BUILD/gromacs-5.1/src/gromacs/simd/impl_ibm_vsx/impl_ibm_vsx.h:452:80: error: 'asm' operand has impossible constraints
> >      __asm__ ("xvcvsxwdp %0,%1" : "=ww" (x) : "ww" ((__vector signed int) (ix)));
> >                                                                                 ^
> 
> Please file a bug report; see  http://gcc.gnu.org/bugs/  .
> Thanks!

I'll try.

> (Btw, you forgot the most important piece of information -- the GCC
> version).

It's gcc-5.1.1 and it's mentioned in the gromacs bug report, but you're
right, I forgot to mention it explicitly in the e-mail, sorry.

Regards,
Dominik
-- 
Fedora http://fedoraproject.org/wiki/User:Rathann
RPMFusion http://rpmfusion.org
"Faith manages."
        -- Delenn to Lennier in Babylon 5:"Confessions and Lamentations"
