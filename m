Message-ID: <3A341F7E.972371F5@mvista.com>
Date: Sun, 10 Dec 2000 19:27:42 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: ddickey@charter.net
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Most current linux source for ppc?
References: <3A32B971.1E847A99@charter.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


"Dan A. Dickey" wrote:

> .....and would like to be on the leading edge instead.
> I'm currently working with a compact pci powerpc board with
> an IBM405GP on it.

I'm trying to merge the 4xx changes into the main 2_5 tree in a
way that minimizes the effect on everyone.  I also want to take the
opportunity to restructure some of the horrible code in places
like mm/init.c in the process.  With the work Tom Rini is doing on
some of the configuration options, I think I can make this happen
soon.

For now, the best place to get the 405GP is from the stuff Frank
Rowand posts on the MontaVista web site.  There isn't anything in
the BitKeeper trees that will work for you right now.


	-- Dan

--

	I like MMUs because I don't have a real life.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
