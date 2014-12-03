Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 02CB71A0060
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Dec 2014 16:46:49 +1100 (AEDT)
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id BF22F140079
 for <linuxppc-dev@ozlabs.org>; Wed,  3 Dec 2014 16:46:48 +1100 (AEDT)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 3 Dec 2014 15:46:48 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 856512CE806F
 for <linuxppc-dev@ozlabs.org>; Wed,  3 Dec 2014 16:46:43 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sB35khSt42664052
 for <linuxppc-dev@ozlabs.org>; Wed, 3 Dec 2014 16:46:43 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sB35keg2021393
 for <linuxppc-dev@ozlabs.org>; Wed, 3 Dec 2014 16:46:42 +1100
Message-ID: <547EA3B0.6040309@linux.vnet.ibm.com>
Date: Wed, 03 Dec 2014 11:16:24 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Shuah Khan <shuahkh@osg.samsung.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@ozlabs.org
Subject: Re: [PATCH V6 9/9] selftests: Make GIT ignore all binaries in powerpc
 test suite
References: <1417507013-11948-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1417507013-11948-10-git-send-email-khandual@linux.vnet.ibm.com>
 <547E039F.7070509@osg.samsung.com>
In-Reply-To: <547E039F.7070509@osg.samsung.com>
Content-Type: text/plain; charset=windows-1252
Cc: mikey@neuling.org, james.hogan@imgtec.com, avagin@openvz.org,
 Paul.Clothier@imgtec.com, peterz@infradead.org, palves@redhat.com,
 oleg@redhat.com, davem@davemloft.net, dhowells@redhat.com, kirjanov@gmail.com,
 davej@redhat.com, akpm@linux-foundation.org, sukadev@linux.vnet.ibm.com,
 tglx@linutronix.de, sam.bobroff@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/02/2014 11:53 PM, Shuah Khan wrote:
> On 12/02/2014 12:56 AM, Anshuman Khandual wrote:
>> > This patch includes all of the powerpc test binaries into the
>> > .gitignore file listing in their respective directories. This
>> > will make sure that GIT ignores all of these test binaries while
>> > displaying status.
>> > 
>> > Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
>> > ---
>> >  .../testing/selftests/powerpc/copyloops/.gitignore |  4 ++++
>> >  tools/testing/selftests/powerpc/mm/.gitignore      |  1 +
>> >  tools/testing/selftests/powerpc/pmu/.gitignore     |  3 +++
>> >  tools/testing/selftests/powerpc/pmu/ebb/.gitignore | 22 ++++++++++++++++++++++
>> >  .../selftests/powerpc/primitives/.gitignore        |  1 +
>> >  5 files changed, 31 insertions(+)
>> >  create mode 100644 tools/testing/selftests/powerpc/copyloops/.gitignore
>> >  create mode 100644 tools/testing/selftests/powerpc/mm/.gitignore
>> >  create mode 100644 tools/testing/selftests/powerpc/pmu/.gitignore
>> >  create mode 100644 tools/testing/selftests/powerpc/pmu/ebb/.gitignore
>> >  create mode 100644 tools/testing/selftests/powerpc/primitives/.gitignore
>> > 
> Creating a single .gitignore at tools/testing/selftests/powerpc will
> make this simpler without having to add one .gitignore for each
> directory underneath.

Sure, will do.

> 
> Thanks for taking on the task to add .gitignore for all powerpc
> binaries.
