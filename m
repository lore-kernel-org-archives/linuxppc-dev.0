Date: Mon, 28 Jun 2004 06:23:59 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Wolfgang Denk <wd@denx.de>,
	Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: loading the kernel and root FS separately from flash?
In-Reply-To: <1088415754.6992.1.camel@hades.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.60.0406280622410.3354@localhost.localdomain>
References: <20040628070916.706A6C109F@atlas.denx.de>
 <1088415754.6992.1.camel@hades.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 28 Jun 2004, David Woodhouse wrote:

> I think it should be OK when it's 4MiB in size. Mount time was far more
> of a problem in JFFS2 many years ago when people were using the 2.4
> kernel. It's a lot faster in 2.6.

this is yet another reason why i'm keen on getting that 2.6 kernel
running on my board.  so far, i still get a full kernel boot, then a
brief foray into user space to start minit, then ... hang.

so i'll just keep pulling the latest updates and keep trying.

rday

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
