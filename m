Return-Path: <tony@bakeyournoodle.com>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 05ECADE09E
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Apr 2009 16:13:53 +1000 (EST)
Date: Wed, 8 Apr 2009 16:13:52 +1000
From: Tony Breeds <tony@bakeyournoodle.com>
To: Michael Ellerman <michael@ellerman.id.au>, linuxppc-dev@ozlabs.org,
	Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Quieten arch/powerpc in a allmodconfig build.
Message-ID: <20090408061352.GH16602@bilbo.ozlabs.org>
References: <2c4bcf8d1d7083ff53ce5b556765e96676a007fb.1239165378.git.tony@bakeyournoodle.com>
	<1239167335.10104.26.camel@localhost>
	<20090408055126.GG16602@bilbo.ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20090408055126.GG16602@bilbo.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 08, 2009 at 03:51:26PM +1000, Tony Breeds wrote:
 
> Hmm actually I think you're right.  I dont want to push my luck with the gcc
> hackers though

Replying to myself.

Yes this is a gcc bug but one introduced by CONFIG_TRACE_ALL_BRANCHES (or
whatever that's called).

Yours Tony
