Date: Mon, 1 Apr 02 11:31:41 PST
From: msokolov@ivan.Harhan.ORG (Michael Sokolov)
Message-Id: <0204011931.AA28474@ivan.Harhan.ORG>
To: linux-galileo@source.mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: [Linux-galileo] ev64260 bi_rec patch
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tom Rini <trini@kernel.crashing.org> wrote:

> So the always-correct call for platform_init() is:
> parse_bootinfo((struct bi_record *) (r3 + KERNELBASE));

Yes!

Mark A. Greer <mgreer@mvista.com> responded:

> Is there a reason we shouldn't just fix find_bootinfo then?

How are you going to fix it? How is it going to find out where in the vast
expanses of system memory the bootloader has stuffed the bi_recs? How do you
code ESP in C?

MS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
