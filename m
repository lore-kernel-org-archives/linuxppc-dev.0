Date: Sat, 4 Aug 2001 09:07:03 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Samuel Rydh <samuel@entropy.crashing.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Versioned module symbols broken for PPC?
Message-ID: <20010804090703.B32537@opus.bloom.county>
References: <20010804153849.A2056@ibrium.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010804153849.A2056@ibrium.se>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Aug 04, 2001 at 03:38:49PM +0200, Samuel Rydh wrote:

> The support for versioned symbols seems to be broken.
> After a mrproper recompile, /proc/ksyms contains entries
> like

What distro are you running?  They work fine on debian/sid, but YDL2
shipped w/ a broken modutils (need to yup update).

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
