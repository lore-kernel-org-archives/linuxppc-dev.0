Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 277942C0091
 for <linuxppc-dev@ozlabs.org>; Wed,  5 Sep 2012 15:30:03 +1000 (EST)
Message-ID: <1346822983.2257.50.camel@pasglop>
Subject: Re: 3.5+: yaboot, Invalid memory access
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christian Kujau <lists@nerdbynature.de>
Date: Wed, 05 Sep 2012 15:29:43 +1000
In-Reply-To: <alpine.DEB.2.01.1209042222270.25392@trent.utfs.org>
References: <alpine.DEB.2.01.1207302235170.26923@trent.utfs.org>
 <alpine.DEB.2.01.1209032310220.25392@trent.utfs.org>
 <1346741491.7619.12.camel@concordia>
 <alpine.DEB.2.01.1209040223380.25392@trent.utfs.org>
 <1346807308.2257.14.camel@pasglop>
 <alpine.DEB.2.01.1209042222270.25392@trent.utfs.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Steven Rostedt <rostedt@goodmis.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2012-09-04 at 22:25 -0700, Christian Kujau wrote:
> I sure hope that other people will benefit from this as well. I can't 
> stand the thought that you guys are always putting out fixes for this
> ol' 
> PowerBook of mine :-\

Well, for some strange reason I didn't observe the problem on a couple
of old macs here, might have got lucky or something (could depend on
whether might_sleep() is compiled to do something or not... depends
on .config debug options).

Anyways, I'll send that fix to Linus asap. Thanks for reporting !

Cheers,
Ben.
