From: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
To: "Stefan Jeglinski" <jeglin@4pi.com>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: Radeon 7000 in 9500 - which slot?
Date: Thu, 10 Oct 2002 11:51:46 +0200
Message-Id: <20021010095147.976@192.168.4.1>
In-Reply-To: <p05100301b9cab28e01a8@[192.168.0.8]>
References: <p05100301b9cab28e01a8@[192.168.0.8]>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>I have seen in Linux-PPC archives (mostly YDL archives) that a Radeon
>7000 must live in the top slot of a 9500 to work in Linux. Any truth
>to this rumor still? Indeed I have this card in the 4th slot, and I
>get a crash into the debugger while booting 2.4.20pre5. Should I
>provide a backtrace or just put it in the top slot?

Yes, provide a backtrace. I suspect you need the radeon in a slot
where the low IO addresses are available for XFree to work, but
neither radeonfb nor offb should have this limitation, so the
crash you have is a bug.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
