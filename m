Date: Tue, 27 Apr 2004 12:33:48 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Christopher R. Johnson" <cjohnson@gcctech.com>
Cc: Wolfgang Denk <wd@denx.de>, Sergey Urvanov <abs@dts.ru>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: ioperm
Message-ID: <20040427193348.GD1655@smtp.west.cox.net>
References: <20040427164405.B19C9C109F@atlas.denx.de> <408EACA5.8090005@gcctech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <408EACA5.8090005@gcctech.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Apr 27, 2004 at 02:55:33PM -0400, Christopher R. Johnson wrote:

>
> Normally I would agree, except that he's getting link errors with
> ioperm, inb and outb - he's not even running the code.  As to whether
> the code will work, you have an excellent point.  Maybe we're both
> right, so beers all around!

You get link errors on 'ioperm' 'inb' and 'outb' because they don't
exist on PPC.  Wolfgang is of course correct. :)

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
