Date: Thu, 13 Nov 2003 09:10:31 +0100 (CET)
From: Geir Frode Raanes <geirfrs@invalid.ed.ntnu.no>
To: llandre <r&d@wawnet.biz>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Silicon Motion VGA controllers and PPC architecture
In-Reply-To: <5.1.1.6.0.20031112173538.01bd2e78@dns.struinfo.it>
Message-ID: <20031113085435.N79832@invalid.ed.ntnu.no>
References: <5.1.1.6.0.20031112173538.01bd2e78@dns.struinfo.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, 12 Nov 2003, llandre wrote:

> I'm looking for a VGA controller to use with an embedded PPC405-based system.
> I had a look at the Silicon Motion chips (712/722) and they seem very
> suited for embedded applications.

Errr - may I ask what is special about this brand?
I believe ATI is the only manufacturer of VGA chips that actually
support alternative architectures, at least PowerPC[MAC].

 http://www.ati.com/products/embedded/overview.html

> Unfortunately the techical support claims that these chips, because the
> presence of x86 BIOS, support only the x86 architecture. Anybody can
> confirm this?

I once attempted to follow the flow of a x86 BIOS.
In other words, I disassembled it. It was intriguing for a while.
You might want to do the same thing with this expansion BIOS -
after all, you are only interested in the initialization sequence.

--
  ******************************************************
  Never ever underestimate the power of human stupidity.
  -Robert Anson Heinlein

		GeirFRS@INVALID.and.so.forth
  ******************************************************

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
