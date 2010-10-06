Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp07.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0AFC8B6F11
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  6 Oct 2010 12:28:29 +1100 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp07.au.ibm.com (8.14.4/8.13.1) with ESMTP id o961STb3005803
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Oct 2010 12:28:29 +1100
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o961STgP2985998
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Oct 2010 12:28:29 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o961SS2K005319
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Oct 2010 12:28:28 +1100
Content-Type: text/plain; charset=UTF-8
Subject: Re: [PATCH 05/18] powerpc: Wire up 44x little endian boot for
	remaining 44x targets
From: Ian Munsie <imunsie@au1.ibm.com>
To: Josh Boyer <jwboyer@gmail.com>
In-reply-to: <AANLkTins34TrEWj618_4XBRwGGFqRSehwWEp7jBubvsu@mail.gmail.com>
References: <1285916771-18033-1-git-send-email-imunsie@au1.ibm.com>
	<1285916771-18033-6-git-send-email-imunsie@au1.ibm.com>
	<AANLkTins34TrEWj618_4XBRwGGFqRSehwWEp7jBubvsu@mail.gmail.com>
Date: Wed, 06 Oct 2010 12:28:29 +1100
Message-Id: <1286327715-sup-584@au1.ibm.com>
Cc: paulus <paulus@samba.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Excerpts from Josh Boyer's message of Fri Oct 01 21:27:37 +1000 2010:
> > From: Ian Munsie <imunsie@au1.ibm.com>
> >
> > I haven't tested booting a little endian kernel on any of these targets,
> > but they all claim to be 44x so my little endian trampoline should work
> > on all of them, so wire it up on:
> >
> > bamboo
> > katmai
> > kilauea
> > rainer
> > sam440ep
> > sequoia
> > warp
> > yosemite
> > ebony
> 
> I see no reason to do this at all.  If you haven't tested them and
> there is no demand, there's no reason to wire them up.  Some might
> actively want to disallow LE mode anyway, like the Warp or Sam440EP.

I wasn't aware that the Warp and Sam440EP disallowed LE mode - I'll
definitely unwire them and move the ARCH_SUPPORTS_LITTLE_ENDIAN to just
the sub-arch's that support it.

As for the other boards, I would like to wire them up if they are able
to support LE mode - If anyone has one handy I would love to hear if
they are able to begin booting a LE kernel with these patches, or when &
how they fail.

Cheers,
-Ian
