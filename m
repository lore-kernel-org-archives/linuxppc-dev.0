Subject: Re: Broadcom BCM94306
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gabriel Paubert <paubert@iram.es>
Cc: Segher Boessenkool <segher@kernel.crashing.org>,
	linas@austin.ibm.com, valvoline <valvoline@vrlteam.org>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20040116195406.GA25566@iram.es>
References: <20040114161107.GM2658@adapter.n0skillz.org>
	 <20040114181350.B40506@forte.austin.ibm.com>
	 <70D6BF86-473D-11D8-A8C3-000A95A4DC02@kernel.crashing.org>
	 <20040115115023.GA12001@iram.es>
	 <C404D01A-475A-11D8-A8C3-000A95A4DC02@kernel.crashing.org>
	 <20040116195406.GA25566@iram.es>
Content-Type: text/plain
Message-Id: <1074309942.8359.24.camel@gaston>
Mime-Version: 1.0
Date: Sat, 17 Jan 2004 14:25:43 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Anyway, since you seem to have ties inside IBM ;-), you might
> know why they do not even give a list of differences of the
> 970 implementation. I know from another source that the 970 does
> not have BATs, but supports large pages with a size of 16MB.

Yup, it's more/less a POWER4 in this regard (which is probably
as badly documented :)

I'll check out the status of public specs, I _think_ that there is
some doc in the process of beeing cleaned up & declassified for this
chip, but I'm not 100% sure at this point.

> Now the fact that the 970 does not support backwards-endian is a very
> good thing. From time to time (although it has been less frequent
> recently) somebody suggest on the list that Linux/PPC switches to the
> dark side of the endianness. The fact that some processors don't support
> it will be a killer argument.

Hehe, you know, there isn't much risk that we take such a patch in
the first place anyway :)

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
