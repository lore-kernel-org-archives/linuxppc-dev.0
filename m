Reply-To: <acurtis@onz.com>
From: "Allen Curtis" <acurtis@onz.com>
To: "Arto Vuori" <avuori@ssh.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: 8260 IDMA experience?
Date: Mon, 3 Jun 2002 06:20:54 -0700
Message-ID: <NCBBIINEHIPFGJPLBEIFOEAFDIAA.acurtis@onz.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <3CFB620E.9F8643EB@ssh.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> I have been using IDMA to transfer data between kernel memory and a
> FPGA. I also did some testing with memory-to-memory transfers and i
> didn't find them to be worth the trouble. Performance ain't that great.
> You probably get more speed by copying with your CPU, though you might
> avoid some cache trashing.

So it works but it may not be as fast as a memcpy(). Sounds like more
testing is required to determine the overall benefit of freeing the
processor.

> I did also notice that when i am doing memory-to-peripheral (or
> vice-versa) transfers, IDMA corrupts simultaneous Ethernet traffic
> unless IDMA is set to low-priority mode. Same might apply for
> memory-to-memory transfers.

What 8260 chip revision are you using? I have found lots of problems when
rev A processors but rev C has been much better.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
