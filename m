Date: Tue, 13 Nov 2001 16:30:24 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	Roman Zippel <zippel@linux-m68k.org>, Jun Sun <jsun@mvista.com>,
	"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	Linux/MIPS Development <linux-mips@oss.sgi.com>,
	Linux/m68k <linux-m68k@lists.linux-m68k.org>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
	<rz@linux-m68k.org>
Subject: Re: [RFC] generic MIPS RTC driver
In-Reply-To: <20011113074424.A16723@cpe-24-221-152-185.az.sprintbbd.net>
Message-ID: <Pine.LNX.4.33.0111131627580.3818-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

On Tue, 13 Nov 2001, Tom Rini wrote:

> > http://linux-m68k-cvs.apia.dhs.org/
>
> That's the non-generic m68k version tho, yes?  Or did Roman do it in
> that tree too?

That version is even more recent than the one currently in the APUS
repository. :)
But I tested it also under APUS, so you only need to provide
[gs]et_rtc_time and it should work.

bye, Roman


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
