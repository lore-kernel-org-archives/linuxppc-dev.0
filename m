From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15529.7312.132845.46847@argo.ozlabs.ibm.com>
Date: Tue, 2 Apr 2002 12:50:56 +1000 (EST)
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: Tom Rini <trini@kernel.crashing.org>,
	Michael Sokolov <msokolov@ivan.Harhan.ORG>,
	linux-galileo@source.mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: [Linux-galileo] ev64260 bi_rec patch
In-Reply-To: <3CA87831.974F719D@mvista.com>
References: <0203292359.AA12953@ivan.Harhan.ORG>
	<3CA4E98B.F7A7ECE0@mvista.com>
	<20020401152507.GB6360@opus.bloom.county>
	<3CA87831.974F719D@mvista.com>
Reply-To: paulus@samba.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Mark A. Greer writes:

> > So the always-correct call for platform_init() is:
> > parse_bootinfo((struct bi_record *) (r3 + KERNELBASE));
>
> Is there a reason we shouldn't just fix find_bootinfo then?

The reason why I split the original parse_bootinfo into two pieces,
find_bootinfo and parse_bootinfo, was to allow for the case where the
bootloader passes in the address of the bi_recs.  In other words,
if you know where the bi_recs are, you don't need to call
find_bootinfo, just parse_bootinfo.

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
