Subject: Re: Radeon 7000 in 9500 - which slot?
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Stefan Jeglinski <jeglin@4pi.com>,
	linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20021010095147.976@192.168.4.1>
References: <p05100301b9cab28e01a8@[192.168.0.8]>
	<20021010095147.976@192.168.4.1>
Content-Type: text/plain; charset=ISO-8859-1
Date: 10 Oct 2002 15:31:03 +0200
Message-Id: <1034256663.4898.99.camel@tibook>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Don, 2002-10-10 at 11:51, Benjamin Herrenschmidt wrote:
>
> >
> >I have seen in Linux-PPC archives (mostly YDL archives) that a Radeon
> >7000 must live in the top slot of a 9500 to work in Linux. Any truth
> >to this rumor still? Indeed I have this card in the 4th slot, and I
> >get a crash into the debugger while booting 2.4.20pre5. Should I
> >provide a backtrace or just put it in the top slot?
>
> Yes, provide a backtrace. I suspect you need the radeon in a slot
> where the low IO addresses are available for XFree to work,

Shouldn't matter with Option "UseFBDev".


--
Earthling Michel Dänzer (MrCooper)/ Debian GNU/Linux (powerpc) developer
XFree86 and DRI project member   /  CS student, Free Software enthusiast


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
