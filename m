Return-Path: <dstn@cs.toronto.edu>
Received: from cliff.cs.toronto.edu (cliff.cs.toronto.edu [128.100.3.120])
	by ozlabs.org (Postfix) with ESMTP id 3F7EA679E2
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Mar 2006 00:33:04 +1100 (EST)
Date: Mon, 13 Mar 2006 08:33:01 -0500 (EST)
From: Dustin Lang <dstn@cs.toronto.edu>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: suspend2 on PowerBook: keyboard doesn't work on resume
In-Reply-To: <1142232047.4228.1.camel@quad.lan>
Message-ID: <Pine.LNX.4.58.0603130828440.7287@monte.ai>
References: <Pine.LNX.4.58.0603112043460.25986@monte.ai>
	<1142232047.4228.1.camel@quad.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi,

> > I'm trying to get suspend2 working on my PowerBook G4 of Oct 2003 vintage.
> >
> > I'm running kernel 2.6.15.6 with the 2.6.15.1 suspend2 patch (it applied
> > and built fine).

> Interesting. I was pretty sure that version wouldn't work at all :->

Do you mean that version of suspend2, or that combination of kernel and
suspend2 patch?  I can try a different combination of versions if you
suspect some other configuration will work...

> There's an ADB keyboard -- this all probably suggests that the ADB
> driver from pre-resume and original kernel are stepping onto each other.
> Maybe they have no good enough power management?

Perhaps.  Nigel Cunningham, the main suspend2 developer, suggested that I
post this problem to this list to see if anyone knew what was happening.

Thanks,
dustin.
