Date: Fri, 8 Feb 2002 17:46:36 +0000
From: Adrian Cox <adrian@humboldt.co.uk>
To: Jim Thompson <jim@musenki.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MPC107 I2C
Message-Id: <20020208174636.08cddc5e.adrian@humboldt.co.uk>
In-Reply-To: <15459.65390.787694.577725@gargle.gargle.HOWL>
References: <20020208094057.799c099a.adrian@humboldt.co.uk>
	<3C63F5A4.5070608@embeddededge.com>
	<20020208162309.395f7c2f.adrian@humboldt.co.uk>
	<15459.65390.787694.577725@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, 8 Feb 2002 10:40:14 -0600
Jim Thompson <jim@musenki.com> wrote:

> No linux drivers, but the moto code (for the 8240) is in the ppcboot
> tree these days, and I know that gbios has enough of i2c up to read
> SODIMMs.

I suspected as much. I wrote the GBIOS code, which does DIMM reading and
also can store environment variables in I2C eeproms. If there's no
driver out there I'll need to convert the code from polling to
interrupts and fit it into the Linux i2c framework.

--
Adrian Cox
http://www.humboldt.co.uk/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
