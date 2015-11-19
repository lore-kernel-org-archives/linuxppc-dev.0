Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42B8F1A09B9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2015 20:59:44 +1100 (AEDT)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Thu, 19 Nov 2015 15:29:39 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 5EE921258060
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2015 15:29:47 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tAJ9xYZS1704274
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2015 15:29:34 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tAJ9xXF8011478
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2015 15:29:34 +0530
Message-ID: <564D9D85.1090201@linux.vnet.ibm.com>
Date: Thu, 19 Nov 2015 15:29:33 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Denis Kirjanov <kda@linux-powerpc.org>, Rashmica Gupta <rashmicy@gmail.com>
CC: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: Standardise on NR_syscalls rather than
 __NR_syscalls.
References: <1447913093-28342-1-git-send-email-rashmicy@gmail.com>
 <CAOJe8K0yHTdymRbEo=itvK-AYiNzQLLspNgTyyzADkzpPxpzHw@mail.gmail.com>
In-Reply-To: <CAOJe8K0yHTdymRbEo=itvK-AYiNzQLLspNgTyyzADkzpPxpzHw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/19/2015 02:45 PM, Denis Kirjanov wrote:
> On 11/19/15, Rashmica Gupta <rashmicy@gmail.com> wrote:
>> > Most architectures use NR_syscalls as the #define for the number of
>> > syscalls.
>> >
>> > We use __NR_syscalls, and then define NR_syscalls as __NR_syscalls.
>> >
>> > __NR_syscalls is not used outside arch code, whereas NR_syscalls is. So as
>> > NR_syscalls must be defined and __NR_syscalls does not, replace
>> > __NR_syscalls
>> > with NR_syscalls.
> Hi,
> 
> But what's wrong with the current code? Why do we need such change?

Yeah, just out of curiosity. Why we had both __NR_syscalls and
NR_syscalls to begin with ?
