From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jeff Rugen <jprugen@earthlink.net>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: RTC and SCSI for PowerStack/2.4.6 Kernel
Date: Mon, 9 Jul 2001 16:47:58 +0200
Message-Id: <20010709144758.31505@smtp.adsl.oleane.com>
In-Reply-To: <000e01c10884$e4201e60$0401a8c0@trex>
References: <000e01c10884$e4201e60$0401a8c0@trex>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Did anything change in regards to oops output on crashes since 2.2.x?  I'm
>not suprised that the kernel would crash/hang without producing any, but I
>thought I'd ask to make sure.

2.4 can Oops instead of always panic'ing, but it's frequent that you
are too much locked up already to be able to read the oops report.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
