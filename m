Return-Path: <shuahkh@osg.samsung.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C82921A05E0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jan 2015 11:16:38 +1100 (AEDT)
Received: from lists.s-osg.org (lists.s-osg.org [54.187.51.154])
 by ozlabs.org (Postfix) with ESMTP id 76C6B14017F
 for <linuxppc-dev@ozlabs.org>; Wed, 14 Jan 2015 11:16:37 +1100 (AEDT)
Message-ID: <54B5B561.40406@osg.samsung.com>
Date: Tue, 13 Jan 2015 17:16:33 -0700
From: Shuah Khan <shuahkh@osg.samsung.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] selftests/powerpc: Add .gitignore for powerpc selftests
References: <1421192997-17003-1-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1421192997-17003-1-git-send-email-mpe@ellerman.id.au>
Content-Type: text/plain; charset=windows-1252
Cc: linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Please add a commit log.

On 01/13/2015 04:49 PM, Michael Ellerman wrote:
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  .../testing/selftests/powerpc/copyloops/.gitignore |  4 ++++
>  tools/testing/selftests/powerpc/mm/.gitignore      |  1 +
>  tools/testing/selftests/powerpc/pmu/.gitignore     |  3 +++
>  tools/testing/selftests/powerpc/pmu/ebb/.gitignore | 22 ++++++++++++++++++++++
>  .../selftests/powerpc/primitives/.gitignore        |  1 +
>  tools/testing/selftests/powerpc/tm/.gitignore      |  1 +
>  6 files changed, 32 insertions(+)
>  create mode 100644 tools/testing/selftests/powerpc/copyloops/.gitignore
>  create mode 100644 tools/testing/selftests/powerpc/mm/.gitignore
>  create mode 100644 tools/testing/selftests/powerpc/pmu/.gitignore
>  create mode 100644 tools/testing/selftests/powerpc/pmu/ebb/.gitignore
>  create mode 100644 tools/testing/selftests/powerpc/primitives/.gitignore
>  create mode 100644 tools/testing/selftests/powerpc/tm/.gitignore

Please create a single .gitignore for all targets right under
tools/testing/selftests/powerpc instead of multiple .gitignore
files.

thanks,
-- Shuah

-- 
Shuah Khan
Sr. Linux Kernel Developer
Open Source Innovation Group
Samsung Research America (Silicon Valley)
shuahkh@osg.samsung.com | (970) 217-8978
