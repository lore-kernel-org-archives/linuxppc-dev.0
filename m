Message-ID: <3C20BAE5.3180684F@chinook.com>
Date: Wed, 19 Dec 2001 11:05:57 -0500
From: Peter Desnoyers <pdesnoyers@chinook.com>
MIME-Version: 1.0
To: Jeff Studer <jstuder@aquilagroup.com>,
	"linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: PCI QSPAN2 resource conflicts
References: <3C1F9452.AB979826@aquilagroup.com> <3C1F8DE8.9FA7CECE@chinook.com> <3C1FBADD.FF66E2A7@aquilagroup.com> <3C20B5E2.4C3AA604@chinook.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I wrote:
>
> br0 = f4000001, i/o at 0xf4000000, size 128 (weird - assigned from
> bottom of range here, not top)
> br1 = f5ffff80, memory at 0xf5ffff80 size 128
>
> You can't have it both ways - 0xf5ffffxx is either I/O or memory, but
> not both.

I'm forgetting - the values in the registers are actual PCI I/O and
memory addresses, so there's no issue if they overlap.  (the physical
addresses mapped to them on the CPU side can't overlap, though) And when
I was talking about target image programming in the QSpan, I should have
been referring to the bus addresses, not the physical addresses.

However, I still get the feeling that there's something badly wrong with
the way you've got your base registers mapped on the two devices, plus
your device is just plain turned off.

--
.....................................................................
 Peter Desnoyers            (781) 457-1165   pdesnoyers@chinook.com
 Chinook Communications     (617) 661-1979   pjd@fred.cambridge.ma.us
 100 Hayden Ave, Lexington MA 02421

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
