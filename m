Date: Fri, 26 Apr 2002 20:35:05 -0700
From: andrew may <acmay@acmay.homeip.net>
To: Armin <akuster@pacbell.net>
Cc: andrew may <acmay@acmay.homeip.net>,
	linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: [PATCH] IBM ocp I2C
Message-ID: <20020426203505.A1819@ecam.san.rr.com>
References: <20020423200127.G20394@ecam.san.rr.com> <3CC9BD30.7050002@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3CC9BD30.7050002@pacbell.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Apr 26, 2002 at 01:48:48PM -0700, Armin wrote:
> > In this patch I dump getown and getclock because they aren't
> > used and I am sure there is a better way to do things.
>
> this does not work on Walnut since "procfreq" is not part of openbios
> and the PLLMR does not exsist on the stb03 or 03  so this changes wont
> go in.

I don't have a stb03 or even know what chip it uses, so I have
no idea what to do about it. We should have some generic 4xx
functions to get the CPU/PLB/OPB clocks so we can calculate what
the I2C div should be. We could always try trusing what the BIOS
sets the divider to as well.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
