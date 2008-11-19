Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18723.31762.522696.647294@cargo.ozlabs.ibm.com>
Date: Wed, 19 Nov 2008 13:38:10 +1100
From: Paul Mackerras <paulus@samba.org>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 0/7] Porting dynmaic ftrace to PowerPC
In-Reply-To: <alpine.DEB.1.10.0811180853390.15003@gandalf.stny.rr.com>
References: <20081116212428.938752312@goodmis.org>
	<18720.42209.880409.297291@cargo.ozlabs.ibm.com>
	<alpine.DEB.1.10.0811171035530.2919@gandalf.stny.rr.com>
	<alpine.DEB.1.10.0811180853390.15003@gandalf.stny.rr.com>
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Steven Rostedt writes:

> Can I add your Acked-by: to all these patches that I submitted? I'm going 
> to recommit them with a consistent subject (all lower case ppc), but I'm 
> not going to change the patches themselves.
> 
> Would you two be fine with that? Or at least one of you?

My preference would be for the patches to go through the powerpc tree
unless there is a good reason for them to go via another tree.

The style we use for the headline is "powerpc: Add xyz feature" or
"powerpc/subsystem: Fix foo bug".

As for the acked-by, I feel I first need to go through the whole
series again with the changes you have made recently.  Have you
reworked the earlier patches to avoid introducing any bugs, rather
than just fixing the bugs with later patches?  If you haven't, are you
sure that the bugs won't cause any problems in bisecting?

Also, what's the best place to find the latest patch set?

Thanks again for doing all this work.

Paul.
  
