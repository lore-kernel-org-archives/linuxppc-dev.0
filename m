Date: Fri, 16 Jul 2004 09:41:52 +0200
From: Guido Guenther <agx@sigxcpu.org>
To: Rob Weir <rweir@ertius.org>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: pmdisk oops(?) on g4 ibook
Message-ID: <20040716074152.GC3698@bogon.ms20.nix>
References: <20040701041703.GH27929@ooder.ertius.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040701041703.GH27929@ooder.ertius.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Jul 01, 2004 at 02:17:03PM +1000, Rob Weir wrote:
> I've been using Guido's pmdisk patch with...a fair amount of success,
> but it occasionally oopses on resume (even with
> USB/dmasound/therm_adt746x modules unloaded), and fairly often takes a
Hmm...I've never seen this. I'll have a look.

> looooooooong time to suspend (more then 3 minutes), sitting at the
I think this is a general problem of pmdisk, not powerpc specific, not
nice though.
Cheers,
 -- Guido

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
