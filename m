From: benh@kernel.crashing.org
To: Tom Rini <trini@kernel.crashing.org>,
	Linux/PPC BK repository <linuxppc@helium.Harhan.ORG>
Cc: <linuxppc-commit@source.mvista.com>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: Incoming to helium.harhan.org:/home/linuxppc/linuxppc_2_4_alt
Date: Mon, 8 Apr 2002 18:58:06 +0100
Message-Id: <20020408175806.9080@mailhost.mipsys.com>
In-Reply-To: <20020408152026.GG2716@opus.bloom.county>
References: <20020408152026.GG2716@opus.bloom.county>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>We shouldn't be #ifdef'ing externs, since it doesn't matter.  The
>pmac/prep/chrp ones were hidden just because the line above was, iirc.
>
>And the one downside to the GENERIC_PPC32 platform_init, is that we're
>back to adding:
>#ifdef CONFIG_x
> case _MACH_x:
>  x_init(...);
>  break;
>#endif
>
>Which I think Paul was happy to see die :)

No, in the version I'm implementing for 2.5, the ppc_md structure of
each board will be statically defined and contain the init function.
A global array will contain ppc_md pointers indexed by machine.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
