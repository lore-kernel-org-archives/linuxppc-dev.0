From: Hollis Blanchard <hollisb@us.ibm.com>
To: "Matthew S. McClintock" <mattsm@arlut.utexas.edu>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: cpu_setup_6xx.S:19:22: ppc_defs.h: No such file or directory
Date: Thu, 15 Jan 2004 19:25:23 +0000
Cc: Christian <evil@g-house.de>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
References: <1074025766.23751.2.camel@chuck.arlut.utexas.edu> <1074131648.5123.48.camel@gaston> <1074186989.23751.9.camel@chuck.arlut.utexas.edu>
In-Reply-To: <1074186989.23751.9.camel@chuck.arlut.utexas.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200401151925.24746.hollisb@us.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thursday 15 January 2004 17:16, Matthew S. McClintock wrote:
> On Wed, 2004-01-14 at 19:54, Benjamin Herrenschmidt wrote:
> >
> > If it's not created for you, then something is wrong in your build
> > process, or you source tree contains crap or whatever. It definitely
> > works fine with the upstream sources.
>
> Well it is from the same kernel tree and same config, I just copy it
> because sometimes the current tree does not make that file correctly. I
> don't know what else to do, does anyone have any idea why my tree is not
> building this file every time correctly in the first place?

Just a guess, but I don't think 2.4 trees work perfectly with parallel builds
(make -jN). It could be that one build needs ppc_defs.h before the other has
created it yet.

--
Hollis Blanchard
IBM Linux Technology Center


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
