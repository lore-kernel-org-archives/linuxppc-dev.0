Date: Mon, 3 Jun 2002 11:16:14 +0200 (CEST)
From: Geir Frode Raanes <geirfrs@invalid.ed.ntnu.no>
To: Khai Trinh <kqtrinh@yahoo.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: PCI 3.3V vs. 5V support in the 440GP
In-Reply-To: <20020531213526.78227.qmail@web11505.mail.yahoo.com>
Message-ID: <20020603105456.I43281-100000@invalid.ed.ntnu.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, 31 May 2002, Khai Trinh wrote:

>
> Does anybody design a PCI card that has to handle PCI
> 3.3V and 5V? The 440GP support only pci 3.3v and we
> are thinking of making it support both 3.3v and 5v.
>
> Is there a voltage conversion chip out there that does

Short of a full blown transparent PCI bridge, there
is no reliable way of doing this that I know of.

PCI is an underterminatet bus that relies on reflected
waves to pump the combined pulse above the logic 1 mark.
It is therefore not simply a 3V3 <-> 5V problem you have,
but also a transmission line problem. Traditional buffering
is therefor out of the question. But nothing stops you from
trying. You might also try analog switches steered by the
bus grant signal, with clamping on the inside. But I have
no confidence in that soulution either.

PCI is designed to ban all 'clever' solutions of the past.
You can tell by the spesification that the designers know
all the tricks of the trade by heart and have put implicit
barriers against them into the specification. They where
definitely not going to sit by and have ISA all over again.
That's good, but from our point of view it's kind of annoing.
OTOH we no longer have to face anyone elses clever solutions.

--
  ******************************************************
  Never ever underestimate the power of human stupidity.
  -Robert Anson Heinlein

		GeirFRS@invalid.and.so.forth
  ******************************************************


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
