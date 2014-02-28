Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B0FD42C0086
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Feb 2014 20:04:41 +1100 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 28 Feb 2014 19:04:41 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id BF1262CE8052
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Feb 2014 20:04:38 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1S94O1u10944780
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Feb 2014 20:04:25 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1S94b6Y008569
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Feb 2014 20:04:37 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: liu ping fan <qemulist@gmail.com>
Subject: Re: [PATCH] mm: numa: bugfix for LAST_CPUPID_NOT_IN_PAGE_FLAGS
In-Reply-To: <CAJnKYQkVziWMmCL=rTakSA4955VMvFnaFtFdmexQAKUfTuVv_Q@mail.gmail.com>
References: <1391563546-26052-1-git-send-email-pingfank@linux.vnet.ibm.com>
 <20140213152009.b16a30d2a5b5c5706fc8952a@linux-foundation.org>
 <87k3cifgzz.fsf@linux.vnet.ibm.com>
 <20140227154104.4e3572f1d9e2692d431d1a4e@linux-foundation.org>
 <877g8fn8qw.fsf@linux.vnet.ibm.com>
 <CAJnKYQkVziWMmCL=rTakSA4955VMvFnaFtFdmexQAKUfTuVv_Q@mail.gmail.com>
Date: Fri, 28 Feb 2014 14:34:31 +0530
Message-ID: <871tynmwv4.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
 Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

liu ping fan <qemulist@gmail.com> writes:

> On Fri, Feb 28, 2014 at 12:47 PM, Aneesh Kumar K.V
> <aneesh.kumar@linux.vnet.ibm.com> wrote:
>> Andrew Morton <akpm@linux-foundation.org> writes:
>>
> Thanks for sending V2.  Since the ppc machine env is changed by
> others, I am blocking on setting up the env for re-test this patch.
> And not send out it quickly.

I sent an updated v3 also taking care of xchg

http://article.gmane.org/gmane.linux.kernel/1657613

-aneesh
