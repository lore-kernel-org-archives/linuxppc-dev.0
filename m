Date: Tue, 28 May 2002 16:42:59 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: linuxppc-dev@lists.linuxppc.org, debian-powerpc@lists.debian.org,
	yellowdog-devel@lists.terrasoftsolutions.com
Subject: BK users read this
Message-ID: <20020528234259.GH5997@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello.  For the moment, if you're using the bk trees, you need to make
sure that the 'parent' property is set to ppc.bkbits.net or
source.mvista.com.   If you're using one of the other bk domains for
your trees, such as ppc.bkserver.net, do:
$ bk parent `bk parent -p | sed s/bkserver/bkbits/`

>From the root of your tree.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
