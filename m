Date: Fri, 30 Jul 2004 08:46:11 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Leigh Brown <leigh@solinno.co.uk>
Cc: paulus@samba.org, linuxppc-dev@lists.linuxppc.org,
	barbieri@gmail.com
Subject: Re: [0/9] Support for old IBM PReP boxes
Message-ID: <20040730154611.GL16468@smtp.west.cox.net>
References: <20040729213319.GA5857@george.solinno.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040729213319.GA5857@george.solinno.co.uk>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Jul 29, 2004 at 10:33:19PM +0100, Leigh Brown wrote:

> This set of patches add support for old IBM PReP machines.  They are
> not perfect, but they are known working on the E20, E30, 140, 240
> and F30.  The F40 is not currently working, but it doesn't work at
> all without these patches so I'm not too concerned right now.

OK.  Thinking back to last time, I asked about being able to blacklist
some machines Residual Data (since it's crap on some, but I don't have
the dumps handy) and you mentioned that you'd like to do fixups on the
data since there's a few cases where the data is mostly good, just with
one or two incorrect things.  And it doesn't look like either are
here... yet.

Could you do a 10/9 patch that adds a bit of help to the PREP_RESIDUAL
config option along the lines of:
"When this information is incorrect, it could lead to the machine
behaving incorrectly.  If this happens, please disable PREP_RESIDUAL and
try again."

And change the existing "Unless you expect to boot on a PReP system,
there is no need to select Y." to "If you are running a PReP system, say
Y here, otherwise say N."

> As 060-old-openpic.diff has not shown up any problems on any machines
> I think it's worth applying, but if Tom is still unhappy then it can
> be left for now.

Since I don't think we can get it in for 2.6.8, and I'd rather not push
this particular change so close to release, lets try and get these in
early in 2.6.9 so they get hammered on as much as possible before a full
release.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
