From: Cort Dougan <cort@fsmlabs.com>
Date: Thu, 19 Dec 2002 11:06:09 -0700
To: Tom Rini <trini@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: PPC Tree structures (Was, at some point: Re: Support for Arctic platform (405LP based))
Message-ID: <20021219180609.GD1048@host109.name>
References: <20021213043628.GI21319@zax.zax> <20021212215126.V23952@duath.fsmlabs.com> <20021213151808.GI19456@opus.bloom.county> <20021215121526.M30941@duath.fsmlabs.com> <15869.5023.549830.146265@argo.ozlabs.ibm.com> <20021215174120.E30568@duath.fsmlabs.com> <20021216150442.GJ6095@opus.bloom.county> <20021216124931.B9431@duath.fsmlabs.com> <20021216201301.GA2513@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20021216201301.GA2513@opus.bloom.county>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


} But regardless of all of that, there's nothing related to this being a
} 'marcelo' tree or not as you can't pick and choose bk csets without
} everything preceeding it.  Ideally we can get to the point of not really
} needing a seperate tree like 2.2 is (which could go if someone wants to
} sit down and think about the LongTrail-specific changes in there).

There's a great advantage to it being based on Marcelo's tree.  I can pull
in several projects that I need along with the PPC changes I need into my
own tree.  I think that would help a lot of people out.

In fact, it should help merging with Marcelo a great deal.  You can easily
pull in main-line changes.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
