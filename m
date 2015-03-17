Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 376D91A0163
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Mar 2015 09:58:22 +1100 (AEDT)
Message-ID: <1426633101.6504.1.camel@ellerman.id.au>
Subject: Re: [PATCH v4 5/5] selftests/powerpc: Add test for VPHN
From: Michael Ellerman <mpe@ellerman.id.au>
To: Greg Kurz <gkurz@linux.vnet.ibm.com>
Date: Wed, 18 Mar 2015 09:58:21 +1100
In-Reply-To: <20150317124932.67fb8296@bahia.local>
References: <20150223151444.21565.65452.stgit@bahia.local>
 <1426566089-1351-1-git-send-email-mpe@ellerman.id.au>
 <20150317124932.67fb8296@bahia.local>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-03-17 at 12:49 +0100, Greg Kurz wrote:
> On Tue, 17 Mar 2015 15:21:29 +1100
> Michael Ellerman <mpe@ellerman.id.au> wrote:
> 
> > From: Greg Kurz <gkurz@linux.vnet.ibm.com>
> > 
> > The goal is to verify vphn_unpack_associativity() parses VPHN numbers
> > correctly. We feed it with a variety of input values and compare with
> > expected results.
> > 
> > PAPR+ does not say much about VPHN parsing: I came up with a list of
> > tests that check many simple cases and some corner ones. I wouldn't
> > dare to say the list is exhaustive though.
> > 
> > Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
> > [mpe: Rework harness logic and rename to test-vphn]
> > Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> > ---
> > 
> > I reworked this a little bit, let me know if it looks OK to you.
> > 
> > I renamed the test to test-vphn, and I changed the test loop to only call the
> > harness once, but report all the individual test results as well.
> 
> I guess it is safe to assume we don't have an infinite loop bug hidding in
> each individual test case.

Well if we do the whole test will be killed by the harness, so we'll still
notice.

> I am okay with the changes. I don't know if it is needed but here's my:
> 
> Reviewed-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
 
Thanks.

cheers
