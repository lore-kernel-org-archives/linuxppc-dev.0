Return-Path: <tony@bakeyournoodle.com>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E7C59DDFAD
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Apr 2009 15:51:26 +1000 (EST)
Date: Wed, 8 Apr 2009 15:51:26 +1000
From: Tony Breeds <tony@bakeyournoodle.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] Quieten arch/powerpc in a allmodconfig build.
Message-ID: <20090408055126.GG16602@bilbo.ozlabs.org>
References: <2c4bcf8d1d7083ff53ce5b556765e96676a007fb.1239165378.git.tony@bakeyournoodle.com>
	<1239167335.10104.26.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1239167335.10104.26.camel@localhost>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 08, 2009 at 03:08:55PM +1000, Michael Ellerman wrote:

> The getter routines in here could really multiplex their return values
> with a negative error code, which I generally prefer, but this works I
> guess.

I was hoping someone would notice and suggest it.  tag you're it!

> Do you need a new spacebar? :D

nowhydoyouask?
 
> This one is a bug surely?

Hmm actually I think you're right.  I dont want to push my luck with the gcc
hackers though

> Gah, gcc sucks. It should just not warn in these cases where it doesn't
> know wth is going on.

I don't think you'll get any arguments.  it only there was a -Wnowarnunused!

Yours Tony
