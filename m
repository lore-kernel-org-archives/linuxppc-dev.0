Message-ID: <3AF740C0.F65FBCB8@mvista.com>
Date: Mon, 07 May 2001 20:41:36 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Eli Chen <eli@routefree.com>
Cc: Gabriel Paubert <paubert@iram.es>, brian.kuschak@skystream.com,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: dcache BUG()
References: <Pine.HPX.4.10.10105072359470.22253-100000@gra-ux1.iram.es> <3AF72CA8.52163E55@mvista.com> <03a001c0d74e$60022c70$4b00000a@foolio1> <3AF73161.26986237@mvista.com> <040a01c0d754$1bf6d5c0$4b00000a@foolio1>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Eli Chen wrote:

> The book is titled "PowerPC Microprocessor Family:....

I left that one at home today.

> I searched through the 405GP user manual, and it makes no mention of if it
> checks the reservation address or not, just like you said.

I grabbed my stack of Motorola manuals.  All of the 6xx/7xx/8xx manuals
have a UISA section that describes the behavior of all implementation
dependent instructions.  The lwarx/stwcx behavior is clearly defined,
along with either 16 or 32 word granularity.......I have Gabriel's
patch floating around on a couple of systems for testing.  If you
try it, let me know the results please.

Thanks.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
