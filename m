Date: Wed, 10 Oct 2001 18:05:29 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Val Henson <val@nmt.edu>, linuxppc-dev@lists.linuxppc.org
Subject: Re: SBS Palomar II/IV/V port
Message-ID: <20011010180529.A11067@cpe-24-221-152-185.az.sprintbbd.net>
References: <20011010122415.A22918@boardwalk> <20011010213037.30369@smtp.wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20011010213037.30369@smtp.wanadoo.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Oct 10, 2001 at 11:30:37PM +0200, Benjamin Herrenschmidt wrote:

> I'll eventually push some code in the upcoming 1 or 2 days that
> does the kernel-side of getting passed pointer-based birecs. I
> will eventually throw in a couple of new birec definitions as
> well.

Can we please not commit this just yet?  2.5 will open up soon
hopefully...  Maybe after 2.4.12 or so.  I think it would be a bad thing
to put this in the 2_4 trees (either of 'em) inititally.  Throwing
around patches tho would be good. :)

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
