Message-ID: <39AE80BD.D86B34DA@embeddededge.com>
Date: Thu, 31 Aug 2000 11:58:53 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Gabriel Paubert <paubert@iram.es>,
        "Michel Ddnzer"
	<daenzerm@student.ethz.ch>,
        Tony Mantler <nicoya@apia.dhs.org>,
        Tom Rini
	<trini@kernel.crashing.org>, Dan Malek <dan@netx4.com>,
        linuxppc-dev
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: Platform configuration (was: Re: CONFIG_PPC != Mac)
References: <Pine.LNX.4.10.10008311714050.390-100000@cassiopeia.home>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Geert Uytterhoeven wrote:

> And since there are people who care about embedded PPC systems, it would be
> great to at least have _the choice_ to compile a small specific kernel or a
> large generic one.

Yeah, well, I am used to continually losing this battle.  Although
embedded PowerPC is likely to have _lots_ more installations than
the desktop, we'll just survive on the pieces left behind.  A pretty
running desktop gets lots of press coverage while code that acutally
runs the infrastructure of the world is unknown (I guess we are doing
a great job, then :-).

I am just happy that I can finally build a kernel for the MPC8xx that
doesn't require I configure an ADB keyboard.  I also like building the
same sources for all of my Mac workstations and servers as well.

I would also like to see us spend a little more time trying to
stabilize 2.4 instead of trying to solve elaborate configuration and
boot schemes.  That is what 2.5 is for.


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
