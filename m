From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mark Jaffe <wizards@wizdev.net>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: MACE networking (NOT!)
Date: Mon, 26 Nov 2001 09:09:15 +0100
Message-Id: <20011126080915.18485@smtp.wanadoo.fr>
In-Reply-To: <B8272394.E34C%wizards@wizdev.net>
References: <B8272394.E34C%wizards@wizdev.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Hi, listas! I am engaged in a crusade to get a PowerMac 8500 with dual-604e
>card online running YellowDog 2.0. I have the 2.4.10-B0a SMP kernel
>installed, and am continually thwarted getting it into production due to
>faulty networking.
>
>The built-in networking refuses to work properly under Linux. I have no
>problems with MacOS, it operates with either a static IP (at the Co-Lo) or
>under DHCP (from an AirPort base station in the home office.) But in Linux,
>DHCP gets an IP but will not make any connection, and with the static IP at
>the Co-Lo it will perform for a few hours then become unreachable. Has this
>issue ever been seen? Is there any way to diagnose what is going on and
>resolve this problem?
>
>Mark

There are 2 things you can do:

 1- Try with one CPU. The mace driver isn't really SMP safe (I can
fix that). Tell me if it helps.

 2- Tell me the mace chip version (printed by the driver during boot)
and try my latest rsync tree as a "workaround" for some broken revs
was found in Darwin and I ported it to the linux driver.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
