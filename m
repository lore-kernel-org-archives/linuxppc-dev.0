Return-Path: <bergner@vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 4D254B6F85
 for <linuxppc-dev@ozlabs.org>; Wed,  2 Nov 2011 05:54:10 +1100 (EST)
Received: from /spool/local
 by e4.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <bergner@vnet.ibm.com>;
 Tue, 1 Nov 2011 14:45:34 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 pA1IixkS3416272
 for <linuxppc-dev@ozlabs.org>; Tue, 1 Nov 2011 14:44:59 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pA1IiwLQ012012
 for <linuxppc-dev@ozlabs.org>; Tue, 1 Nov 2011 16:44:59 -0200
Subject: Re: powerpc 476, Little-endian, pte fault
From: Peter Bergner <bergner@vnet.ibm.com>
To: Santosh Kumar <santoshkumar.a@gmail.com>
In-Reply-To: <CAJw04pA3mDOgHrOvPxeXR8Fw6Jn1kBz9qSrgq2vJ7HPpyQwSbg@mail.gmail.com>
References: <CAJw04pD24W_nGSLheWunCa_o7QqBmRf_TSAD44EkzazigRe_nQ@mail.gmail.com>
 <12144.1320040276@neuling.org>
 <CAJw04pAh5QDQMkUHbj9=rRPiUCZejimHiydCJFMAoZeSd_ydhA@mail.gmail.com>
 <20440.1320054588@neuling.org>	<1320060214.30202.34.camel@pasglop>
 <CAJw04pBpXsTS4=FeG5ZF3nqORXhiOZ=3V60cFCuJfgTiJcCh2g@mail.gmail.com>
 <1320155074.2996.190.camel@otta>
 <CAJw04pA3mDOgHrOvPxeXR8Fw6Jn1kBz9qSrgq2vJ7HPpyQwSbg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 01 Nov 2011 13:44:53 -0500
Message-ID: <1320173093.2996.244.camel@otta>
Mime-Version: 1.0
Cc: Michael Neuling <mikey@neuling.org>, Ian Munsie <ianmunsi@au1.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2011-11-01 at 22:44 +0530, Santosh Kumar wrote:
> I had a problem configuring the GCC for 476 in little endian mode,

What type of problem?  I assume the binutils you are building
against has 476 support too, correct?  You'll need that.


> So is this PTE fault related to the compiler options?

This could be caused by anything, but I highly doubt this is
caused by a compiler option issue.  My $$ are that you either
have a bug in your kernel patch or there are more places in
the kernel source that need patching.

Peter
