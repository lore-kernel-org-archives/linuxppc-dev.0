Message-ID: <3BAA7096.54F24F9B@mvista.com>
Date: Thu, 20 Sep 2001 18:41:26 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Craig MacDonald <macdonldc@netscape.net>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: PPCBoot and IMMR remapping for linux 2.4 on sbc8260
References: <4E48AD2F.671BD424.031B03A1@netscape.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Craig MacDonald wrote:

> .....I have been trying to change the immr_base
> in assembly, but it does not seem to work.

If the boot rom hasn't changed the default address (which they
sometimes do but don't tell you :-), just to this:

	lis	r5, 0x0f01
	lis	r4, 0xf000
	stw	r4, 0x1a8(r5)


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
