Date: Tue, 12 Feb 2002 19:25:01 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Cc: linuxppc-dev@lists.linuxppc.org,
	yellowdog-devel@lists.yellowdoglinux.com
Subject: Re: new G4 dual 1 gig is here - how to install?
Message-ID: <20020213022501.GE9951@opus.bloom.county>
References: <416D9C76-201E-11D6-BE69-0003938E434C@ivey.uwo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <416D9C76-201E-11D6-BE69-0003938E434C@ivey.uwo.ca>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Feb 12, 2002 at 08:08:57PM -0500, Kevin B. Hendricks wrote:

> When I select it I immediately get the prompt for linux, mac, or cdrom
> boot but as soon as I hit l for linux it recycles.

Have you tried dropping to OF by hand and booting yaboot directly?  Or
even doing a 'make zImage' and trying to boot
arch/ppc/boot/images/vmlinux.elf-pmac right out of OF?  There's always a
chance the script is 'wrong' in the new box and is trying to boot
something that isn't there.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
