From: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
To: "Xavier Grave" <grave@ipno.in2p3.fr>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: new powermac pb : no hard disk found
Date: Fri, 18 Oct 2002 14:07:10 +0200
Message-Id: <20021018120711.18174@192.168.4.1>
In-Reply-To: <200210180941.LAA07730@ipnmail.in2p3.fr>
References: <200210180941.LAA07730@ipnmail.in2p3.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>I've received the new bi processor (2*1GHz) and I try to boot with a debian
>CDrom. I boot in the install24 yaboot mode but the only ide device found is
>the DVD writer.
>
>What do I need to do ?
>
>Thanks in advance for any answer...
>xavier

Put your hard disk on the ATA/66 bus, the ATA/100 one isn't supported
yet. You should also make sure you are using my latest kernel tree.

In order to get the ATA/100 working properly, I need to figure out
the way the various timings are configured on this new controller,
I've started disassembling the MacOS X driver but didn't finish yet.

Unfortunately, unlike the Apple's ATA/66 and earlier IDE controllers,
the source code for this new ones's driver haven't been open sourced
by Apple as part of Darwin. (At least not yet).

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
