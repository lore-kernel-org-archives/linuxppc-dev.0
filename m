In-Reply-To: <Pine.GSO.4.58.0312171126330.24864@waterleaf.sonytel.be>
References: <20031216105656.GA5291@iliana> <1071642293.753.414.camel@gaston> <200312170717.36564.jel@ntlworld.com> <1071646057.6370.482.camel@gaston> <20031217095139.GC2283@iliana> <Pine.GSO.4.58.0312171126330.24864@waterleaf.sonytel.be>
Mime-Version: 1.0 (Apple Message framework v606)
Message-Id: <0E17AA13-30A8-11D8-9472-000A95A4DC02@kernel.crashing.org>
Cc: Debian GNU/Linux PPC <debian-powerpc@lists.debian.org>,
	Lee Braiden <jel@ntlworld.com>, Sven Luther <sven.luther@wanadoo.fr>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Would setting the CONFIG_RTC option break the powerpc kernel on your machine ?
Date: Wed, 17 Dec 2003 16:45:35 +0100
To: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> No, that's VIA as in Versatile Interface Adapter, not as in VIA
> Technologies.
> It used to be a separate chip in the old 68000 days, but now it's
> integrated in
> some Mac fabric (e.g. Mac I/O).

Actually, there is no RTC chip _at all_ in NewWorld Macs.  The PMU
itself keeps the time (from a 32768Hz clock).


Segher


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
