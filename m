In-Reply-To: <20040116195406.GA25566@iram.es>
References: <20040114161107.GM2658@adapter.n0skillz.org> <20040114181350.B40506@forte.austin.ibm.com> <70D6BF86-473D-11D8-A8C3-000A95A4DC02@kernel.crashing.org> <20040115115023.GA12001@iram.es> <C404D01A-475A-11D8-A8C3-000A95A4DC02@kernel.crashing.org> <20040116195406.GA25566@iram.es>
Mime-Version: 1.0 (Apple Message framework v609)
Message-Id: <64789114-4A89-11D8-9C4D-000A95A4DC02@kernel.crashing.org>
Cc: linas@austin.ibm.com, valvoline <valvoline@vrlteam.org>,
	linuxppc-dev@lists.linuxppc.org
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Broadcom BCM94306
Date: Mon, 19 Jan 2004 15:11:36 +0100
To: Gabriel Paubert <paubert@iram.es>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Anyway, since you seem to have ties inside IBM ;-), you might
> know why they do not even give a list of differences of the
> 970 implementation.

I guess the documentation is just not ready for public consumption.
I don't really know.

> I know from another source that the 970 does
> not have BATs, but supports large pages with a size of 16MB.

The BAT thing at least is documented (and has been documented
_for ever_ -- see the PEM, the 970 is a 64-bit chip.  Get the
rev 2.0 PEM from the 970 doc page).

The large page thing is cpu specific afaik (from memory).


Segher


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
