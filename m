Message-ID: <3CA87831.974F719D@mvista.com>
Date: Mon, 01 Apr 2002 10:09:37 -0500
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
Cc: Michael Sokolov <msokolov@ivan.Harhan.ORG>,
	linux-galileo@source.mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: [Linux-galileo] ev64260 bi_rec patch
References: <0203292359.AA12953@ivan.Harhan.ORG> <3CA4E98B.F7A7ECE0@mvista.com> <20020401152507.GB6360@opus.bloom.county>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tom Rini wrote:

> OK.  The problem is that the original PPC location of the bi_recs was

Acutally, my problem was that I misread his respone.  I thought he was trying to
say the find_bootinfo was in the bootloader or something like that.

> So the always-correct call for platform_init() is:
> parse_bootinfo((struct bi_record *) (r3 + KERNELBASE));

Is there a reason we shouldn't just fix find_bootinfo then?

Mark


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
