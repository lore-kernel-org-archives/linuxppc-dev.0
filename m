Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D74511A006B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Sep 2014 12:24:42 +1000 (EST)
Message-ID: <1411525460.4184.29.camel@pasglop>
Subject: Re: [PATCH 3/3] powerpc/ftrace: simplify prepare_ftrace_return
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Anton Blanchard <anton@samba.org>
Date: Wed, 24 Sep 2014 12:24:20 +1000
In-Reply-To: <20140924122202.62feb950@kryten>
References: <1410937624-25140-1-git-send-email-anton@samba.org>
 <1410937624-25140-3-git-send-email-anton@samba.org>
 <20140923194604.233bdbad@gandalf.local.home>
 <20140923195436.45ae7e2c@gandalf.local.home>
 <20140924122202.62feb950@kryten>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 Steven Rostedt <rostedt@goodmis.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-09-24 at 12:22 +1000, Anton Blanchard wrote:
> Hi Steve,
> 
> > > This could be broken from the earlier patches, I haven't run just
> > > this test. I probably should on them.
> > 
> > I went back and tested, and it breaks under the first patch.
> 
> Thanks for testing. It looks like some toolchains have issues
> other than the -fno-no-omit-frame-pointer one, and -mno-sched-epilog
> works around it.
> 
> I'll drop that patch and respin.

Or maybe do a toolchain check / or enable it in LE ?

Ben.
