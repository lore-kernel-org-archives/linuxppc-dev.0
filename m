Return-Path: <anton@samba.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 55B4E1A03E0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Sep 2014 12:33:08 +1000 (EST)
Date: Wed, 24 Sep 2014 12:33:07 +1000
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 3/3] powerpc/ftrace: simplify prepare_ftrace_return
Message-ID: <20140924123307.7649bec8@kryten>
In-Reply-To: <1411525460.4184.29.camel@pasglop>
References: <1410937624-25140-1-git-send-email-anton@samba.org>
 <1410937624-25140-3-git-send-email-anton@samba.org>
 <20140923194604.233bdbad@gandalf.local.home>
 <20140923195436.45ae7e2c@gandalf.local.home>
 <20140924122202.62feb950@kryten> <1411525460.4184.29.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 Steven Rostedt <rostedt@goodmis.org>, Alan Modra <amodra@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben,

> > I'll drop that patch and respin.
> 
> Or maybe do a toolchain check / or enable it in LE ?

We are scratching our heads trying to remember details of the issue
right now. In retrospect we should have linked the gcc bugzilla or
gcc commit details in the kernel commit message :)

Steve: what gcc version are you building with?

Anton
