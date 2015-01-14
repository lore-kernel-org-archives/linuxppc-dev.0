Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A0B291A084F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jan 2015 14:50:16 +1100 (AEDT)
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E8E24140272
 for <linuxppc-dev@ozlabs.org>; Wed, 14 Jan 2015 14:50:15 +1100 (AEDT)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 14 Jan 2015 09:20:13 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id D2C551258043
 for <linuxppc-dev@ozlabs.org>; Wed, 14 Jan 2015 09:20:56 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0E3o8nw59900136
 for <linuxppc-dev@ozlabs.org>; Wed, 14 Jan 2015 09:20:08 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0E3o7BC028886
 for <linuxppc-dev@ozlabs.org>; Wed, 14 Jan 2015 09:20:08 +0530
Message-ID: <54B5E76F.6050307@linux.vnet.ibm.com>
Date: Wed, 14 Jan 2015 09:20:07 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>, Shuah Khan <shuahkh@osg.samsung.com>
Subject: Re: [PATCH] selftests/powerpc: Add .gitignore for powerpc selftests
References: <1421192997-17003-1-git-send-email-mpe@ellerman.id.au>
 <54B5B561.40406@osg.samsung.com> <1421201759.10748.8.camel@ellerman.id.au>
In-Reply-To: <1421201759.10748.8.camel@ellerman.id.au>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/14/2015 07:45 AM, Michael Ellerman wrote:
> On Tue, 2015-01-13 at 17:16 -0700, Shuah Khan wrote:
>> Please add a commit log.
>  
> What does it need to say?
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

Hey Michael,

I had already posted a similar patch in this regard along with the ptrace
patches last month. Thats why I mentioned in the cover letter that
gitignore updates for all these tests will come from that patch series
instead of from this one. 

https://lkml.org/lkml/2014/12/2/80

Regards
Anshuman
