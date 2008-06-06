Return-Path: <glikely@secretlab.ca>
Received: from ag-out-0708.google.com (ag-out-0708.google.com [72.14.246.250])
	by ozlabs.org (Postfix) with ESMTP id 5D94BDE0AA
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Jun 2008 00:53:21 +1000 (EST)
Received: by ag-out-0708.google.com with SMTP id 8so3352875agc.0
	for <linuxppc-dev@ozlabs.org>; Fri, 06 Jun 2008 07:53:19 -0700 (PDT)
Message-ID: <fa686aa40806060753i76b1d652ldd2bb99f5406dab@mail.gmail.com>
Date: Fri, 6 Jun 2008 08:53:18 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Josh Boyer" <jwboyer@gmail.com>
Subject: Re: 4xx support in arch/ppc is going away Real Soon Now
In-Reply-To: <20080606085601.623ef866@vader.jdub.homelinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080605095253.7df9dbe0@zod.rchland.ibm.com>
	<fa686aa40806050811t4ab2fbfk9eed34d0972376c4@mail.gmail.com>
	<20080606115347.GC472@cs181133002.pp.htv.fi>
	<20080606085601.623ef866@vader.jdub.homelinux.org>
Cc: linuxppc-dev@ozlabs.org, Adrian Bunk <bunk@kernel.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jun 6, 2008 at 7:56 AM, Josh Boyer <jwboyer@gmail.com> wrote:
> On Fri, 6 Jun 2008 14:53:47 +0300
> Adrian Bunk <bunk@kernel.org> wrote:
>
>> On Thu, Jun 05, 2008 at 09:11:48AM -0600, Grant Likely wrote:
>> > On Thu, Jun 5, 2008 at 8:52 AM, Josh Boyer <jwboyer@linux.vnet.ibm.com> wrote:
>> > > This commit (patch omitted due to size) is sitting in my local tree:
>> > >
>> > > commit 0d7efc1e80fc262bcc507a605482c5681e3f082a
>> > > Author: Josh Boyer <jwboyer@linux.vnet.ibm.com>
>> > > Date:   Thu Jun 5 09:46:17 2008 -0500
>> > >
>> > >    ppc/4xx: Remove 4xx support from arch/ppc
>> > >
>> > >    Remove support for PPC 403, 405, and 440 processors from arch/ppc.  The
>> > >    arch/powerpc equivalents should be used.  Boards that are not ported yet
>> > >    will need to be ported to arch/powerpc to have continued support.
>> >
>> > This looks like unneeded churn.
>> >
>> > Paulus, Can we just kill all of arch/ppc for .27 right now?
>>
>> Is anyone already working on doing this and the cleanups that will then
>> be possible?
>>
>> Otherwise I'll be glad to contribute to it.   :)
>
> I think we can handle it.  Thanks though.

BTW Paul, we agreed in your absence on IRC that you should take the
honors of committing the kill arch/ppc patch and the associated top
spot in LWN's top committers list... but there's a price.  You may
very well get mailed the bar tab from the ding-dong-arch-ppc-is-dead
party at OLS this year. >:-}

Oh, and we're going try to create the longest acked-by chain in Linux history.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
