Date: Fri, 30 Jul 2004 17:30:07 +0200
From: Christoph Hellwig <hch@lst.de>
To: Leigh Brown <leigh@solinno.co.uk>
Cc: paulus@samba.org, trini@kernel.crashing.org,
	linuxppc-dev@lists.linuxppc.org, barbieri@gmail.com
Subject: Re: [0/9] Support for old IBM PReP boxes
Message-ID: <20040730153007.GA12298@lst.de>
References: <20040729213319.GA5857@george.solinno.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040729213319.GA5857@george.solinno.co.uk>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Jul 29, 2004 at 10:33:19PM +0100, Leigh Brown wrote:
>
> This set of patches add support for old IBM PReP machines.  They are
> not perfect, but they are known working on the E20, E30, 140, 240
> and F30.  The F40 is not currently working, but it doesn't work at
> all without these patches so I'm not too concerned right now.
>
> As 060-old-openpic.diff has not shown up any problems on any machines
> I think it's worth applying, but if Tom is still unhappy then it can
> be left for now.

I know everyone hates beeing put under pressure, but I'd be really
grateful on a quick okay or not on this for mainline so we can decide on
taking the full patchkit or the small patch for Debian Sarge which will
freeze soon.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
