Return-Path: <rostedt@goodmis.org>
Received: from cdptpa-oedge-vip.email.rr.com
 (cdptpa-outbound-snat.email.rr.com [107.14.166.227])
 by lists.ozlabs.org (Postfix) with ESMTP id BBE291A005A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Sep 2014 09:54:39 +1000 (EST)
Date: Tue, 23 Sep 2014 19:54:36 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH 3/3] powerpc/ftrace: simplify prepare_ftrace_return
Message-ID: <20140923195436.45ae7e2c@gandalf.local.home>
In-Reply-To: <20140923194604.233bdbad@gandalf.local.home>
References: <1410937624-25140-1-git-send-email-anton@samba.org>
 <1410937624-25140-3-git-send-email-anton@samba.org>
 <20140923194604.233bdbad@gandalf.local.home>
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

On Tue, 23 Sep 2014 19:46:04 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

 
> This could be broken from the earlier patches, I haven't run just this
> test. I probably should on them.

I went back and tested, and it breaks under the first patch.

-- Steve
