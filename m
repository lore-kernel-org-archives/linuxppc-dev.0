Date: Thu, 10 Oct 2002 22:32:12 +0200
From: Olaf Hering <olh@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Stefan Jeglinski <jeglin@4pi.com>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Radeon 7000 in 9500 - which slot?
Message-ID: <20021010223212.A12862@suse.de>
References: <p05100301b9cab28e01a8@[192.168.0.8]> <20021010095147.976@192.168.4.1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20021010095147.976@192.168.4.1>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


begin  On Thu, Oct 10, Benjamin Herrenschmidt wrote:

>
> >
> >I have seen in Linux-PPC archives (mostly YDL archives) that a Radeon
> >7000 must live in the top slot of a 9500 to work in Linux. Any truth
> >to this rumor still? Indeed I have this card in the 4th slot, and I
> >get a crash into the debugger while booting 2.4.20pre5. Should I
> >provide a backtrace or just put it in the top slot?
>
> Yes, provide a backtrace. I suspect you need the radeon in a slot
> where the low IO addresses are available for XFree to work, but
> neither radeonfb nor offb should have this limitation, so the
> crash you have is a bug.

we had this one before.

pci_device_to_OF_node() returns null and you pass this to get_property()


Gruss Olaf

--
 $ man Notes

BUGS
       You need http://www.sauerstoff-laden.de/ soon...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
