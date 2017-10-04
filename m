Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y6YlL1M44zDqp2
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Oct 2017 22:36:46 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>, Segher Boessenkool
 <segher@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, Cyril Bur <cyrilbur@gmail.com>,
 akshay.adiga@linux.vnet.ibm.com
Subject: Re: [PATCH v2] powerpc: Blacklist GCC 5.4 6.1 and 6.2
In-Reply-To: <20171003212903.2327154c@kitsune.suse.cz>
References: <20170213033536.8908-1-cyrilbur@gmail.com>
 <20170213154437.GP21840@gate.crashing.org>
 <1487031943.9122.1.camel@gmail.com>
 <20170214014916.GR21840@gate.crashing.org>
 <20171003212903.2327154c@kitsune.suse.cz>
Date: Wed, 04 Oct 2017 22:36:44 +1100
Message-ID: <87lgkrp2k3.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michal Such=C3=A1nek <msuchanek@suse.de> writes:

> On Mon, 13 Feb 2017 19:49:16 -0600
> Segher Boessenkool <segher@kernel.crashing.org> wrote:
>
>> On Tue, Feb 14, 2017 at 11:25:43AM +1100, Cyril Bur wrote:
>> > > > At the time of writing GCC 5.4 is the most recent and is
>> > > > affected. GCC 6.3 contains the backported fix, has been tested
>> > > > and appears safe to use.=20=20
>> > >=20
>> > > 6.3 is (of course) the newer release; 5.4 is a maintenance
>> > > release of a compiler that is a year older.=20=20
>> >=20
>> > Yes. I think the point I was trying to make is that since they
>> > backported the fix to 5.x and 6.x then I expect that 5.5 will have
>> > the fix but since it doesn't exist yet, I can't be sure. I'll add
>> > something to that effect.=20=20
>>=20
>> The patch has been backported to the GCC 5 branch; it will be part of
>> any future GCC 5 release (5.5 and later, if any later will happen; 5.5
>> will).
>>=20
>> Don't be so unsure about these things, we aren't *that*
>> incompetent ;-)
>
> Nonetheless the message is factually correct.
>
>>=20
>> > > Please mention the GCC PR # somewhere in the code, too?=20=20
>> >=20
>> > Sure.=20=20
>
> It seems this has never happened?

>From memory we discovered that there were patched versions of the
compilers in distros, which still reported those version numbers. ie.
the patch would break working compilers.

So Cyril was going to write a test that actually built some code and
checked the generated asm. But I suspect he never got around to it.

cheers
