Date: Thu, 1 Apr 2004 19:59:08 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Sylvain Munaut <tnt@246tNt.com>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: New OCP for 2.6 was (Re: mpc5xxx support )
Message-ID: <20040401195908.A1321@home.com>
References: <67423B18-83E3-11D8-B6FB-000393DBC2E8@motorola.com> <20040401150211.90D85C10A4@atlas.denx.de> <20040401161622.GA26876@smtp.west.cox.net> <406CA75E.2070508@246tNt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <406CA75E.2070508@246tNt.com>; from tnt@246tNt.com on Fri, Apr 02, 2004 at 01:35:58AM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Apr 02, 2004 at 01:35:58AM +0200, Sylvain Munaut wrote:
> I've tried to write the code as cleany as possible, it uses the OCP
> stuff that was on linux-2.5-ocp and also the generic dma stuff.

I'll add you to the list of people developing 2.6 code against the
new OCP:
	Kumar	-> MPC85xx
	Mark G	-> MV64xxx
	Matt	-> IBM4xx
        Sylvain	-> MPC52xx

Just FYI for everybody wondering about new OCP.  The 2.6 port of
BenH's new OCP rewrite is at bk://source.mvista.com/linux-2.5-ocp.
The API and functionality match that of what is currently in
linux-2.4/linuxppc-2.4.  There are a number of changes/improvements
that have been discussed, but I want to get the equivalent to
the 2.4 functionality into 2.6 before we go any further.

BenH and I are slowly working on figuring out what if anything
needs to be done to get this in linux-2.5.

-Matt

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
