Date: Fri, 21 Sep 2001 00:45:58 -0500
From: Troy Benjegerdes <hozer@drgw.net>
To: Mark Salisbury <mbs@mc.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: ppc LE questions (seeking help hand info pointers)
Message-ID: <20010921004558.Q12992@altus.drgw.net>
References: <3BAA0E6F.5050503@mc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3BAA0E6F.5050503@mc.com>; from mbs@mc.com on Thu, Sep 20, 2001 at 11:42:39AM -0400
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> question 4. assuming I was willing to deliver a clean, complete LE
> enabling patch (including devices that are relevant to me), as a compile
> time config option and maintain that patch, what would be the primary
> obstacle to inclusion in the main line.

I think the primary obstacle is that we already have enough problems
breaking obscure machines (embedded, or some old PReP box) whenever
something gets changed.

I suspect it's going to be a signifigant workload to keep a 'ppcle'
up-to-date, and most importantly, working.. you may be better off
maintaining a patch for LE support for the near future.

I for one, would like to see how small one could get a clean, working LE
patch for linux.

If the code isn't intrusive, and forces us to clean up abstraction layers
in headers and such, it could probably be a good thing.

This whole discusion is mostly academic and (in this case) somewhat
incendiary until someone shows up with working code.

My suggestion is go make it work, and if you find ways to clean up the
general PPC code in the process, this will definitely help.

--
Troy Benjegerdes | master of mispeeling | 'da hozer' |  hozer@drgw.net
-----"If this message isn't misspelled, I didn't write it" -- Me -----
"Why do musicians compose symphonies and poets write poems? They do it
because life wouldn't have any meaning for them if they didn't. That's
why I draw cartoons. It's my life." -- Charles Shulz

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
