Date: Tue, 21 May 2002 11:26:17 -0700
From: andrew may <acmay@acmay.homeip.net>
To: Kenneth Johansson <kenneth.johansson@inn.ericsson.se>
Cc: andrew may <acmay@acmay.homeip.net>,
	Kenneth Johansson <kenneth.johansson@etx.ericsson.se>,
	Linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>,
	Armin Kuster <akuster@mvista.com>
Subject: Re: [PATCH] ibm ocp gpio
Message-ID: <20020521112617.C20012@ecam.san.rr.com>
References: <20020520182657.B17318@ecam.san.rr.com> <3CEA0F45.BDBBA25@etx.ericsson.se> <20020521090819.G9190@ecam.san.rr.com> <1021998521.7266.46.camel@swb11>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1021998521.7266.46.camel@swb11>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, May 21, 2002 at 06:28:41PM +0200, Kenneth Johansson wrote:
> On Tue, 2002-05-21 at 18:08, andrew may wrote:
>
> > Well no it doesn't need to be in the driver, but you then are forced with
> > having every other driver doing there own timer to turn off the bit rather
> > than having one timer take care of them all. And do you really want to
>
> Well I don't think that would be a problem and if we are talking led's
> its not going to happen more than a few time a second you have to see
> the thing flash. I don't want more code in the kernel than absolutely
> necessary all it takes is one bug.
>
> If you really want to make something that can't be done other than in
> the driver it's some type of streaming mode and then you have to have
> timers to control the speed. Think any card that needs to program sram
> based FPGA it would probably go many times faster than todays interface.

Look at the code and stop the hand-waving generalities.

The other motto of the kernel is do it once right. If this code is not
there every thing that just wants to turn on a LED for a half second needs
to do their own timer. I have a couple drivers where I use some LED's on the
GPIO pins and I don't want to do a timer in each one of them.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
