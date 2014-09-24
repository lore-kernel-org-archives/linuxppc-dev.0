Return-Path: <rostedt@goodmis.org>
Received: from cdptpa-oedge-vip.email.rr.com
 (cdptpa-outbound-snat.email.rr.com [107.14.166.232])
 by lists.ozlabs.org (Postfix) with ESMTP id 43B8E1A0077
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Sep 2014 12:44:51 +1000 (EST)
Date: Tue, 23 Sep 2014 22:44:47 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH 3/3] powerpc/ftrace: simplify prepare_ftrace_return
Message-ID: <20140923224447.3d6bdaf5@gandalf.local.home>
In-Reply-To: <20140924123307.7649bec8@kryten>
References: <1410937624-25140-1-git-send-email-anton@samba.org>
 <1410937624-25140-3-git-send-email-anton@samba.org>
 <20140923194604.233bdbad@gandalf.local.home>
 <20140923195436.45ae7e2c@gandalf.local.home>
 <20140924122202.62feb950@kryten> <1411525460.4184.29.camel@pasglop>
 <20140924123307.7649bec8@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Alan Modra <amodra@gmail.com>, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 24 Sep 2014 12:33:07 +1000
Anton Blanchard <anton@samba.org> wrote:

> Hi Ben,
> 
> > > I'll drop that patch and respin.
> > 
> > Or maybe do a toolchain check / or enable it in LE ?
> 
> We are scratching our heads trying to remember details of the issue
> right now. In retrospect we should have linked the gcc bugzilla or
> gcc commit details in the kernel commit message :)
> 
> Steve: what gcc version are you building with?
> 

powerpc64-linux-gcc (GCC) 4.6.3

I got it from here:

  https://www.kernel.org/pub/tools/crosstool/files/bin/x86_64/4.6.3/

-- Steve
