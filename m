From: linas@austin.ibm.com
Date: Thu, 15 Jan 2004 13:54:04 -0600
To: Hollis Blanchard <hollisb@us.ibm.com>
Cc: "Matthew S. McClintock" <mattsm@arlut.utexas.edu>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Christian <evil@g-house.de>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: cpu_setup_6xx.S:19:22: ppc_defs.h: No such file or directory
Message-ID: <20040115135404.F40474@forte.austin.ibm.com>
References: <1074025766.23751.2.camel@chuck.arlut.utexas.edu> <1074131648.5123.48.camel@gaston> <1074186989.23751.9.camel@chuck.arlut.utexas.edu> <200401151925.24746.hollisb@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200401151925.24746.hollisb@us.ibm.com>; from hollisb@us.ibm.com on Thu, Jan 15, 2004 at 07:25:23PM +0000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Jan 15, 2004 at 07:25:23PM +0000, Hollis Blanchard wrote:
>
> Just a guess, but I don't think 2.4 trees work perfectly with parallel builds
> (make -jN). It could be that one build needs ppc_defs.h before the other has
> created it yet.

I'll chime in and say that I've seen something like this, if not this
problem exactly.  I was a big user of make -j and I remember that
when the problem showed up, it was real hard to make go away.
Oh, and always at the most inopportune moment ...

--linas

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
