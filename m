Return-Path: <marc.leeman@gmail.com>
Received: from mproxy.gmail.com (rproxy.gmail.com [64.233.170.199])
	by ozlabs.org (Postfix) with ESMTP id 424532BDD7
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Oct 2004 18:01:15 +1000 (EST)
Received: by mproxy.gmail.com with SMTP id 76so285428rnl
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Oct 2004 01:01:14 -0700 (PDT)
Message-ID: <1f729c48041012005441d70d5c@mail.gmail.com>
Date: Tue, 12 Oct 2004 09:54:34 +0200
From: Marc Leeman <marc.leeman@gmail.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	linuxppc-embedded@ozlabs.org
In-Reply-To: <35fb2e59041011151463b2a4bf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1097515329.8508.66.camel@nighteyes.localdomain>
	<547E0D34-1BB5-11D9-909B-003065F9B7DC@embeddededge.com>
	<35fb2e59041011151463b2a4bf@mail.gmail.com>
Cc: 
Subject: Re: Creating rootfs
Reply-To: Marc Leeman <marc.leeman@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> commercial tools at this point. Otherwise, go pay Monta, DENX, or one
> of the other embedded developer supporting companies for a flashy
> solution.

The MV solution is neither small nor flashy.  The filesystem is too
large and contains relatively much crud. If you use it as a
development environment, you can use it as a starting point, but I
would not recommend for a final solution.

If you know what you are doing, roll your own distribution, if you
have little GNU/Linux experience, you can use commercial embedded
distrib vendors. Of course, if you ask unbiassed vendor advice, they
will always claim that you _need_ their distrib (mainly because of
reasons which have little to do with technical ones).

I would recommend crosscompiling your toolchain (e.g. makeroot) and
start from there. There are also several good howtos for debian based
packages.

--=20
ash nazg durbatul=FBk, ash nazg gimbatul,
ash nazg thrakatul=FBk agh burzum-ishi krimpatul
