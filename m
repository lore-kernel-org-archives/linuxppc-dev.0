Date: Thu, 15 Mar 2001 11:19:21 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Stefano Coluccini <s.coluccini@caen.it>
Cc: Bj?rn Wingman <bjowi@ida.liu.se>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: mcpn765
Message-ID: <20010315111921.A872@opus.bloom.county>
References: <yx2r8zzghpd.fsf@aste15.ida.liu.se> <NDBBIFIMCKPOADMAJOKMGEBMDAAA.s.coluccini@caen.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <NDBBIFIMCKPOADMAJOKMGEBMDAAA.s.coluccini@caen.it>; from s.coluccini@caen.it on Thu, Mar 15, 2001 at 06:26:43PM +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Mar 15, 2001 at 06:26:43PM +0100, Stefano Coluccini wrote:

> Check the make file arch/ppc/boot/pp3/Makefile, in the rule for making
> zImage.initrd there is a typo: you must add the -pbp option to the mkprep
> invocation.

This _should_ be fixed in current 2_5.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
