Message-ID: <3C879933.8090200@embeddededge.com>
Date: Thu, 07 Mar 2002 11:45:39 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
Cc: benh@kernel.crashing.org, Paul White <pwhite@bivio.net>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: MPC7455
References: <Pine.LNX.4.21.0203062152510.30207-100000@stimpy.networkrobots.com> <20020306214849.11643@mailhost.mipsys.com> <20020307153005.GF19531@opus.bloom.county>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tom Rini wrote:

> I'd think that outside of CONFIG_ALL_PPC (or wherever CHRP/Pmac end up
> in 2.5.x) we don't care what the firmware did.

That's a very good point.  Anything we do inside of the kernel with
cputable/features must be generic to all of the boards we support.  If
there is something unique (which is always the case of embedded boards :-),
that needs to be done in the bootloader before we get to the kernel or
in the board specific setup files for the platform.

	-- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
