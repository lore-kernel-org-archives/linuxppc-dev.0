In-Reply-To: <8A34C28B-8426-11D8-9FF0-000A95A07384@sands-edge.com>
References: <20040331230620.ACC3BC10A4@atlas.denx.de> <812363C6-8371-11D8-9FF0-000A95A07384@sands-edge.com> <Pine.GSO.4.58.0404011035190.12755@waterleaf.sonytel.be> <8A34C28B-8426-11D8-9FF0-000A95A07384@sands-edge.com>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <665C8CB0-889F-11D8-9744-000393DBC2E8@motorola.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
	Wolfgang Denk <wd@denx.de>
From: Kumar Gala <kumar.gala@motorola.com>
Subject: Re: Proposed Kconfig update patch for help text 
Date: Wed, 7 Apr 2004 09:25:20 -0500
To: John Whitney <jwhitney-linuxppc@sands-edge.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'm trying to figure how how I would fit the e500 core and 85xx into
your descriptions.

- kumar

On Apr 1, 2004, at 3:50 PM, John Whitney wrote:

> Here's the latest Kconfig help-text patch for your consideration.  I
> considered enumerating each chip supported, but that will be a
> maintenance headache, and I'm not even sure I could list them all.  I'm
> fairly sure that the 8250 is supported, but it isn't listed in
> arch/ppc/kernel/cputable.c, so I'm guessing its PVR is covered by the
> 8260 entry.  I don't want to figure out which ones are supported but
> not explicitly covered, so I went with the "##xx" method.
>
> Let me know what you think...
>
> John
>
>
> <Kconfig.patch>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
