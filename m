Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C8CD21A04B7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jan 2015 13:15:59 +1100 (AEDT)
Message-ID: <1421201759.10748.8.camel@ellerman.id.au>
Subject: Re: [PATCH] selftests/powerpc: Add .gitignore for powerpc selftests
From: Michael Ellerman <mpe@ellerman.id.au>
To: Shuah Khan <shuahkh@osg.samsung.com>
Date: Wed, 14 Jan 2015 13:15:59 +1100
In-Reply-To: <54B5B561.40406@osg.samsung.com>
References: <1421192997-17003-1-git-send-email-mpe@ellerman.id.au>
 <54B5B561.40406@osg.samsung.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-01-13 at 17:16 -0700, Shuah Khan wrote:
> Please add a commit log.
 
What does it need to say?

> On 01/13/2015 04:49 PM, Michael Ellerman wrote:
> > Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> > ---
> >  .../testing/selftests/powerpc/copyloops/.gitignore |  4 ++++
> >  tools/testing/selftests/powerpc/mm/.gitignore      |  1 +
> >  tools/testing/selftests/powerpc/pmu/.gitignore     |  3 +++
> >  tools/testing/selftests/powerpc/pmu/ebb/.gitignore | 22 ++++++++++++++++++++++
> >  .../selftests/powerpc/primitives/.gitignore        |  1 +
> >  tools/testing/selftests/powerpc/tm/.gitignore      |  1 +
> >  6 files changed, 32 insertions(+)
> >  create mode 100644 tools/testing/selftests/powerpc/copyloops/.gitignore
> >  create mode 100644 tools/testing/selftests/powerpc/mm/.gitignore
> >  create mode 100644 tools/testing/selftests/powerpc/pmu/.gitignore
> >  create mode 100644 tools/testing/selftests/powerpc/pmu/ebb/.gitignore
> >  create mode 100644 tools/testing/selftests/powerpc/primitives/.gitignore
> >  create mode 100644 tools/testing/selftests/powerpc/tm/.gitignore
> 
> Please create a single .gitignore for all targets right under
> tools/testing/selftests/powerpc instead of multiple .gitignore
> files.

Why? Having separate files makes it less likely we'll get merge conflicts
between different test subdirectores, it also makes it more likely someone
adding a test will notice they need to update the .gitignore in the same
directory.

cheers
