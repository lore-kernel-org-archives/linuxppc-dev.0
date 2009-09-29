Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 394C21007D1
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Sep 2009 17:07:43 +1000 (EST)
Subject: Re: [PATCH] powerpc/8xx: fix regression introduced by cache
	coherency rewrite
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
In-Reply-To: <OF1870F4D5.BB673882-ONC1257640.00233638-C1257640.00236DC9@transmode.se>
References: <20090924004552.GA11737@compile2.chatsunix.int.mrv.com>
	<1253774659.7103.405.camel@pasglop>
	<20090924233346.GA445@compile2.chatsunix.int.mrv.com>
	<1253836376.7103.469.camel@pasglop>
	<20090925013528.GA2584@compile2.chatsunix.int.mrv.com>
	<1253843480.7103.492.camel@pasglop>
	<20090929012106.GA22798@compile2.chatsunix.int.mrv.com>
	<OF1870F4D5.BB673882-ONC1257640.00233638-C1257640.00236DC9@transmode.se>
Content-Type: text/plain
Date: Tue, 29 Sep 2009 17:07:37 +1000
Message-Id: <1254208057.5771.7.camel@pasglop>
Mime-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Rex Feany <RFeany@mrv.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2009-09-29 at 08:26 +0200, Joakim Tjernlund wrote:
> > I've tried sticking tlbil_va() in those places, nothing seems to
> help.
> > In some cases userspace is slow, in other cases userspace is faster
> and
> > unstable: sometimes commands hang, sometimes I am able to ctrl-c and
> > and kill it, sometimes I get other strange crashes or falures (so
> far no
> > kernel oopses though).
> 
> This is exactly what you get when the "cache insn does not update DAR"
> bug hits
> you.

But then why was it working fine before ? Or it wasn't ?

Ben.
