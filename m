From: Gabriel Paubert <paubert@iram.es>
Date: Wed, 21 Jan 2004 18:27:25 +0100
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linas@austin.ibm.com, valvoline <valvoline@vrlteam.org>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Broadcom BCM94306
Message-ID: <20040121172725.GB3814@iram.es>
References: <20040114161107.GM2658@adapter.n0skillz.org> <20040114181350.B40506@forte.austin.ibm.com> <70D6BF86-473D-11D8-A8C3-000A95A4DC02@kernel.crashing.org> <20040115115023.GA12001@iram.es> <C404D01A-475A-11D8-A8C3-000A95A4DC02@kernel.crashing.org> <20040116195406.GA25566@iram.es> <64789114-4A89-11D8-9C4D-000A95A4DC02@kernel.crashing.org> <1074549957.10585.57.camel@gaston> <A3C1C69E-4B72-11D8-BDF1-000A95A4DC02@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <A3C1C69E-4B72-11D8-BDF1-000A95A4DC02@kernel.crashing.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Jan 20, 2004 at 07:01:15PM +0100, Segher Boessenkool wrote:
>
> On 19-jan-04, at 23:05, Benjamin Herrenschmidt wrote:
>
> >
> >>The BAT thing at least is documented (and has been documented
> >>_for ever_ -- see the PEM, the 970 is a 64-bit chip.  Get the
> >>rev 2.0 PEM from the 970 doc page).
> >>
> >>The large page thing is cpu specific afaik (from memory).
> >
> >POWER3 had BATs
>
> Sure, but BATs are not *required* by the 64-bit architecture.
>
>
> Segher
>
>
> p.s.  Well actually, I went to check -- and the PEM 2.0 _does_
> define BATs for 64-bit.  Let's put this under "POWER4 and
> derivatives specific" as well then, until the docs get fixed :-)

Indeed, sorry for the late reply, but I was really wondering how you
could interpret a bit level description of the BATs and the sentences
describing them as "some implementations may not have them" ;-)

There are no mention of big/large/huge pages either[1], nor of
instructions which may have been added for Power4/970 (I know
about mfcrf)

Frankly speaking the current state of the documentation is worrying me,
I remember that when the PPC750 was announced, a lot of documentation
was added to IBM and Motorola websites in a matter of days.

	Regards,
	Gabriel

[1] well, I found some mentions of the large pages in a redbook about
Power4. But that's about all.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
