Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 400wZ350CJzDr8K
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2018 00:24:43 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 christophe leroy <christophe.leroy@c-s.fr>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH 4.14 1/4] powerpc/mm/slice: Remove intermediate bitmap copy
In-Reply-To: <20180310194742.GA12279@kroah.com>
References: <69684e92a32d00c491540e8adfa34fcb50c36244.1520468013.git.christophe.leroy@c-s.fr>
 <20180310001043.GD13963@kroah.com>
 <39af0017-6a9c-a032-8167-40b5f30840f8@c-s.fr>
 <20180310145258.GA6874@kroah.com>
 <84cf5fef-a940-cb2a-431e-5a550f725c4f@c-s.fr>
 <20180310194742.GA12279@kroah.com>
Date: Wed, 14 Mar 2018 00:24:41 +1100
Message-ID: <87r2oof6qu.fsf@concordia.ellerman.id.au>
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

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> On Sat, Mar 10, 2018 at 05:14:22PM +0100, christophe leroy wrote:
>> Le 10/03/2018 =C3=A0 15:52, Greg Kroah-Hartman a =C3=A9crit=C2=A0:
>> > On Sat, Mar 10, 2018 at 08:27:54AM +0100, christophe leroy wrote:
>> > > Le 10/03/2018 =C3=A0 01:10, Greg Kroah-Hartman a =C3=A9crit=C2=A0:
>> > > > On Fri, Mar 09, 2018 at 04:48:59PM +0100, Christophe Leroy wrote:
>> > > > > Upstream 326691ad4f179e6edc7eb1271e618dd673e4736d
>> > > >=20
>> > > > There is no such git commit id in Linus's tree :(
>> > > >=20
>> > > > Please fix up and resend the series.
>> > >=20
>> > > I checked again, it is there
>> > >=20
>> > > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/=
commit/arch/powerpc/mm/slice.c?h=3Dnext-20180309&id=3D326691ad4f179e6edc7eb=
1271e618dd673e4736d
>> >=20
>> > That is linux-next, which has everything and the kitchen sink.  It is
>> > not Linus's tree.  Please wait for these things to be merged into
>> > Linus's tree before asking for the to be merged into the stable tree.
>> > That's a requirement.
>>=20
>> Oops, sorry, I thought everything on kernel.org was official.
>
> That would be a whole lot of "official" :)
>
> Please read:
>     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.ht=
ml
> for what the rules are here, if you haven't already.
>
>> Once it is in, do I resend the patches or do I just ping you ?
>
> You would need to resend the patches (if they need backporting
> manually), or just send a list of the git commit ids that are needed to
> be applied (usually easier.)
>
> Also, why were these patches not tagged with the stable tag to start
> with?  That way they would be automatically included in the stable tree
> when they hit Linus's tree.

Because they're fairly large and invasive and not well tested on other
platforms, so the maintainer is not comfortable with them going straight
to stable :)

Once they've had some testing in Linus' tree at least, then we'll ask
for a backport if there's no issues.

Sorry for the confusion.

cheers
