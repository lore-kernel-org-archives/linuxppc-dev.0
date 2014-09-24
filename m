Return-Path: <anton@samba.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B42031A009E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Sep 2014 12:22:03 +1000 (EST)
Date: Wed, 24 Sep 2014 12:22:02 +1000
From: Anton Blanchard <anton@samba.org>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 3/3] powerpc/ftrace: simplify prepare_ftrace_return
Message-ID: <20140924122202.62feb950@kryten>
In-Reply-To: <20140923195436.45ae7e2c@gandalf.local.home>
References: <1410937624-25140-1-git-send-email-anton@samba.org>
 <1410937624-25140-3-git-send-email-anton@samba.org>
 <20140923194604.233bdbad@gandalf.local.home>
 <20140923195436.45ae7e2c@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi Steve,

> > This could be broken from the earlier patches, I haven't run just
> > this test. I probably should on them.
> 
> I went back and tested, and it breaks under the first patch.

Thanks for testing. It looks like some toolchains have issues
other than the -fno-no-omit-frame-pointer one, and -mno-sched-epilog
works around it.

I'll drop that patch and respin.

Anton
