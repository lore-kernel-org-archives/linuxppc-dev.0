Reply-To: <trevor@carts.com>
From: "Trevor Coolidge" <trevor@carts.com>
To: "Dan Malek" <dan@mvista.com>, "Kevin Fry" <kevin@carts.com>
Cc: "linuxppc emb3dd3d list" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: 8260 Communications Proccessor overload??
Date: Thu, 11 Oct 2001 11:11:36 -0700
Message-ID: <NFBBLOLDFLCOPBEGODOHAEDNCKAA.trevor@carts.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <3BC48D49.6FB5279@mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan,

   We figured out the problem.  As expected it was a software issue.  We had
the internal clock mux set up incorrectly.  The external RXCLK from the phy
was feeding the TXCLK inside FCC3.  Strange that it worked most of the time.

   I can confirm that 3 FCC's can run at full rate.  I will have benchmarks
soon.

Trevor

-----Original Message-----
From: dan@netx4.com [mailto:dan@netx4.com]On Behalf Of Dan Malek
Sent: Wednesday, October 10, 2001 11:03 AM
To: Kevin Fry
Cc: linuxppc emb3dd3d list
Subject: Re: 8260 Communications Proccessor overload??


Kevin Fry wrote:
>
>    Has anyone ever run all 3 FCC ports at the same time with a
> 100Mbit link?

Yeah.....

> ....  I think I'm seeing the Communications Processor get
> overloaded, but Motorola claims there is no problem.

What clock speeds are you running?  Are they full or half duplex
connections?



> the Ethernet PHY (AM79C874) indicates no errors, but the MAC is
> reporting
> CRC errors.

Hmmm...Do you ever see any buffering problems on the Linux driver
side, like the CPU can't keep up with the data?

> .... I have captured the MAC --> PHY transfers on a logic
> analyzer
> and am decoding them at present (I hate computing a CRC-32 by hand).  I
> was
> hoping someone else has experience relative to this situation.

I have seen some noise problems with some boards between the MAC and
PHY.  Some crappy looking layouts worked great, some really pretty
ones had trouble :-).  I don't know if this would be represented as
a CRC error or something else.

Good Luck!  Keep us posted :-).


	-- Dan

---
Incoming mail is certified Virus Free.
Checked by AVG anti-virus system (http://www.grisoft.com).
Version: 6.0.282 / Virus Database: 150 - Release Date: 9/25/2001

---
Outgoing mail is certified Virus Free.
Checked by AVG anti-virus system (http://www.grisoft.com).
Version: 6.0.282 / Virus Database: 150 - Release Date: 9/25/2001


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
