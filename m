In-Reply-To: <1074549957.10585.57.camel@gaston>
References: <20040114161107.GM2658@adapter.n0skillz.org> <20040114181350.B40506@forte.austin.ibm.com> <70D6BF86-473D-11D8-A8C3-000A95A4DC02@kernel.crashing.org> <20040115115023.GA12001@iram.es> <C404D01A-475A-11D8-A8C3-000A95A4DC02@kernel.crashing.org> <20040116195406.GA25566@iram.es> <64789114-4A89-11D8-9C4D-000A95A4DC02@kernel.crashing.org> <1074549957.10585.57.camel@gaston>
Mime-Version: 1.0 (Apple Message framework v609)
Message-Id: <A3C1C69E-4B72-11D8-BDF1-000A95A4DC02@kernel.crashing.org>
Cc: Gabriel Paubert <paubert@iram.es>, linas@austin.ibm.com,
	valvoline <valvoline@vrlteam.org>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Broadcom BCM94306
Date: Tue, 20 Jan 2004 19:01:15 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 19-jan-04, at 23:05, Benjamin Herrenschmidt wrote:

>
>> The BAT thing at least is documented (and has been documented
>> _for ever_ -- see the PEM, the 970 is a 64-bit chip.  Get the
>> rev 2.0 PEM from the 970 doc page).
>>
>> The large page thing is cpu specific afaik (from memory).
>
> POWER3 had BATs

Sure, but BATs are not *required* by the 64-bit architecture.


Segher


p.s.  Well actually, I went to check -- and the PEM 2.0 _does_
define BATs for 64-bit.  Let's put this under "POWER4 and
derivatives specific" as well then, until the docs get fixed :-)


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
