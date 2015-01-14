Return-Path: <shuahkh@osg.samsung.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 463BC1A0C86
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 04:20:14 +1100 (AEDT)
Received: from lists.s-osg.org (lists.s-osg.org [54.187.51.154])
 by ozlabs.org (Postfix) with ESMTP id E361C140161
 for <linuxppc-dev@ozlabs.org>; Thu, 15 Jan 2015 04:20:13 +1100 (AEDT)
Message-ID: <54B6A54A.1050601@osg.samsung.com>
Date: Wed, 14 Jan 2015 10:20:10 -0700
From: Shuah Khan <shuahkh@osg.samsung.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] selftests/powerpc: Add .gitignore for powerpc selftests
References: <1421192997-17003-1-git-send-email-mpe@ellerman.id.au>
 <54B5B561.40406@osg.samsung.com> <1421201759.10748.8.camel@ellerman.id.au>
In-Reply-To: <1421201759.10748.8.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/13/2015 07:15 PM, Michael Ellerman wrote:
> On Tue, 2015-01-13 at 17:16 -0700, Shuah Khan wrote:
>> Please add a commit log.
>  
> What does it need to say?

Explain the change the patch is making. Please see
Documentation/SubmittingPatches for details.

Looks like this patch is no longer needed as I see a new
patch added to the series from Anshuman Khandual.

> 
>> On 01/13/2015 04:49 PM, Michael Ellerman wrote:
>>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>>> ---
>>>  .../testing/selftests/powerpc/copyloops/.gitignore |  4 ++++
>>>  tools/testing/selftests/powerpc/mm/.gitignore      |  1 +
>>>  tools/testing/selftests/powerpc/pmu/.gitignore     |  3 +++
>>>  tools/testing/selftests/powerpc/pmu/ebb/.gitignore | 22 ++++++++++++++++++++++
>>>  .../selftests/powerpc/primitives/.gitignore        |  1 +
>>>  tools/testing/selftests/powerpc/tm/.gitignore      |  1 +
>>>  6 files changed, 32 insertions(+)
>>>  create mode 100644 tools/testing/selftests/powerpc/copyloops/.gitignore
>>>  create mode 100644 tools/testing/selftests/powerpc/mm/.gitignore
>>>  create mode 100644 tools/testing/selftests/powerpc/pmu/.gitignore
>>>  create mode 100644 tools/testing/selftests/powerpc/pmu/ebb/.gitignore
>>>  create mode 100644 tools/testing/selftests/powerpc/primitives/.gitignore
>>>  create mode 100644 tools/testing/selftests/powerpc/tm/.gitignore
>>
>> Please create a single .gitignore for all targets right under
>> tools/testing/selftests/powerpc instead of multiple .gitignore
>> files.
> 
> Why? Having separate files makes it less likely we'll get merge conflicts
> between different test subdirectores, it also makes it more likely someone
> adding a test will notice they need to update the .gitignore in the same
> directory.
> 

It is a matter of reducing the number of files. I am fine with creating
one per directory, if that fits in better with powerpc tests.

-- Shuah


-- 
Shuah Khan
Sr. Linux Kernel Developer
Open Source Innovation Group
Samsung Research America (Silicon Valley)
shuahkh@osg.samsung.com | (970) 217-8978
