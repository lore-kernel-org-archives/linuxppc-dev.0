Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rq9gr3b6xzDqKf
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 17:39:04 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 anton@ozlabs.org, ananth@in.ibm.com, dja@axtens.net,
 naveen.n.rao@linux.vnet.ibm.com, David.Laight@ACULAB.COM
Subject: Re: [PATCH v3 3/4] perf annotate: add powerpc support
In-Reply-To: <20160712023937.GC3387@kernel.org>
References: <1467267262-4589-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
 <1467267262-4589-4-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
 <1467267714.7296.6.camel@ellerman.id.au>
 <57762D2A.9040103@linux.vnet.ibm.com>
 <87vb0j84fb.fsf@@concordia.ellerman.id.au>
 <577F31D9.4050808@linux.vnet.ibm.com>
 <87zipsmsyd.fsf@@concordia.ellerman.id.au>
 <5784543A.9030801@linux.vnet.ibm.com> <20160712023937.GC3387@kernel.org>
Date: Wed, 13 Jul 2016 17:39:01 +1000
Message-ID: <87eg6ym1gq.fsf@@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Arnaldo Carvalho de Melo <acme@kernel.org> writes:

> Em Tue, Jul 12, 2016 at 07:51:46AM +0530, Ravi Bangoria escreveu:
>> Hi Arnaldo,
>> 
>> On Friday 08 July 2016 02:01 PM, Michael Ellerman wrote:
>> > Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com> writes:
>> > 
>> > > On Wednesday 06 July 2016 03:38 PM, Michael Ellerman wrote:
>> > > 
>> > > I've sent v4 which enables annotate for bctr' instructions.
>> > > 
>> > > for 'bctr', it will show down arrow(indicate jump) and 'bctrl' will show
>> > > right arrow(indicate call). But no navigation options will be provided.
>> > > By pressing Enter key on that, message will be shown that like
>> > > "Invalid target"
>> > Great thanks.
>> 
>> I've sent v4 series. Please review it.
>
> If somebody else could do it and provide acks/reviewed by, that would
> help,
>
> Michael, can I get your comments as such?

It looks OK to me. But I don't know the code really, and I haven't had
time to test it personally.

Ravi, have you tested on a big endian machine?

cheers
