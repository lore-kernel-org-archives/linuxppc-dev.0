Date: Wed, 24 Sep 2003 10:17:39 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andreas Oberritter <obi@saftware.de>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] fix build of ibmstb4 and ibmstbx25
Message-ID: <20030924171739.GA30820@ip68-0-152-218.tc.ph.cox.net>
References: <1064372689.822.13.camel@shiva.eth.saftware.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1064372689.822.13.camel@shiva.eth.saftware.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Sep 24, 2003 at 05:04:49AM +0200, Andreas Oberritter wrote:

> Hi Tom,
>
> config.in.diff adds two missing '$' for config variables in
> arch/ppc/config.in and the two other patches update the ocp definitions
> for the stb4xxx and stbx25xx CPUs, so they can be built again. I used
> linuxppc_2_4_devel, but they are needed for linuxppc-2.4, too.

Applied.  Does this mean you have the HW and can test things?

> Any idea why my changes to config.in were visible with bk difftool but
> not with bk diffs? It's the first time I tried to use bk for creating
> patches and I really don't like it. :)

I don't know, I always use bk diffs.  Perhaps you didn't do a 'bk edit'
before hand?

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
