Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3D17B36E.2040502@embeddededge.com>
Date: Mon, 24 Jun 2002 20:03:58 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
Cc: Wolfgang Grandegger <wolfgang.grandegger@bluewin.ch>,
	Wolfgang Denk <wd@denx.de>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH and RFC] Remove request_8xxirq
References: <20020620214551.GI16052@opus.bloom.county> <20020620215844.E66F61030A@denx.denx.de> <20020620221016.GK16052@opus.bloom.county> <3D12F667.30902@bluewin.ch> <20020624170055.GB3489@opus.bloom.county> <3D1793E1.3030509@bluewin.ch> <20020624224100.GL3489@opus.bloom.county>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Tom Rini wrote:

> They're provided to keep compatibility.  I do want to see this get into
> 2.4, and breaking somebodys already working custom driver in 2.4 is bad.

Let's just do the minimal changes in 2.4 to make request_irq() work for
stuff like the PCMCIA drivers.  Forget about the 8259, as I think the only
board that uses it is the MBX, and if people really need it, they can hack
something in as it hasn't worked for years anyway.

> They're gone in the 2.5 version of the patch (since a driver supporting
> 2.5/2.6 will have all sorts of other compatibility macros anyhow).

I'm working on 2.5 now, and I'll implement something better/different
that may not ever make it into 2.4.  Also, you guys have removed all of
the intercepts for RTLinux and RTAI, so I need to put that back in
as well as create an interface for the interrupts.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
