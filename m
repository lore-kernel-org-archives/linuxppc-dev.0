Date: Thu, 10 May 2001 09:10:31 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Murray Jensen <Murray.Jensen@cmst.csiro.au>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: linuxppc_2_5 source tree (and others)
Message-ID: <20010510091031.A27558@opus.bloom.county>
References: <21780.989483882@msa.cmst.csiro.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <21780.989483882@msa.cmst.csiro.au>; from Murray.Jensen@cmst.csiro.au on Thu, May 10, 2001 at 06:38:02PM +1000
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, May 10, 2001 at 06:38:02PM +1000, Murray Jensen wrote:

> Hi, I see that the linuxppc_2_5 bk tree has disappeared from fsmlabs, and
> has been replaced with a linuxppc_2_4_devel tree. Could someone in the
> know please post a quick update what this means, and perhaps what the
> future holds wrt 2.4/2.5 linuxppc (embedded)?

I was hoping Cort would mention this here, but 2_5 has been 'dead' for a
while and is finally gone too.  There's still mirrors of it however.
It will exist again, but when 2.5.0 appears and will be based off the
linux_2_4 tree or so.  Right now 2_4_devel isn't up to date wrt 8xx/4xx, and
some new boards 2_5 had.  I'm working on it. :)

> I guess I should actually ask about what I want :-) The linuxppc_2_5 tree
> had a "drivers/i2c/i2c-algo-8xx.c" file which has disappeared from 2_4_devel.
> I need an i2c driver for linuxppc for the 8260 and figured this would be a
> good place to start. So the question really is what has happened to the 8xx
> i2c driver in the fsmlabs linuxppc_2_5, and has anyone ported this to (or done
> one independently for) the 8260?

These are in 2_4_devel as of last night.  I'm also trying to get ahold of the
i2c maintainers so that it can be in linus' tree eventually.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
