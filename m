Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:32:0:1:25:1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 6B21BB7045
 for <linuxppc-dev@ozlabs.org>; Fri,  6 Apr 2012 03:44:13 +1000 (EST)
To: Stephen Rothwell <sfr@canb.auug.org.au>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: kilauea compilation breaks with v3.3 kernel and ELDK 4.2
MIME-Version: 1.0
Content-type: text/plain; charset=UTF-8
In-reply-to: <20120405100228.9ca940aa4739e81540bb2a6f@canb.auug.org.au>
References: <4F69C553.6070409@gmail.com>
 <CA+5PVA7+vPZmLBzkXOFwTM+kLMYHPDgVW4Jcm91XSxW=Ng-Y6g@mail.gmail.com>
 <20120321162549.8C1D0202A4D@gemini.denx.de>
 <1332633218.2882.16.camel@pasglop>
 <CA+5PVA4pGhbrM1P8Dbjaxw_1_ZgEweimLCSc1xrw0Rombr_2rg@mail.gmail.com>
 <CADNf2swF2EVO2u-yPziF2z6HyF6jRBvVsQC2nbY=W2sXJpp2hQ@mail.gmail.com>
 <1333152184.30734.3.camel@pasglop>
 <CA+5PVA6jQgme0sS=i8yYX6b_R5179+BtWPh7QXCGNfoLTCt46A@mail.gmail.com>
 <20120404192101.2A558200243@gemini.denx.de>
 <20120405100228.9ca940aa4739e81540bb2a6f@canb.auug.org.au>
Date: Thu, 05 Apr 2012 19:44:04 +0200
Message-Id: <20120405174404.A4086200240@gemini.denx.de>
Cc: linuxppc-dev@ozlabs.org, robert.karl.berger@gmail.com,
 Frank =?UTF-8?B?U3ZlbmRzYsO4ZQ==?= <frank.svendsboe@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear Stephen Rothwell,

In message <20120405100228.9ca940aa4739e81540bb2a6f@canb.auug.org.au> you wrote:
>
> > ELDK 4.2 is based on gcc version 4.2.2 / binutils version 2.17.50.0.12
> > 20070128.  This is obviously to old for this code.  I do not see an
> > actual problem with that - nobody can expect that we support old tol
> > chain versions forever.
> 
> The requirements are documented in Documentation/Changes where we say we
> need gcc 3.2 and binutils 2.12.  Not that that is very relevant to this
> discussion. ;-)

Indeed. I doubt you can build any working PPC kernel with these old
tools.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"Consistency requires you to be as ignorant today as you were a  year
ago."                                              - Bernard Berenson
