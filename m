Message-ID: <393E80D7.9918BBE1@embeddededge.com>
Date: Wed, 07 Jun 2000 13:05:27 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Grant Carter <gcarter@eng.uct.ac.za>
CC: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: SMC2
References: <393E4156.E7E8153A@eng.uct.ac.za>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Grant Carter wrote:

> When I look at my manuals, I see no reference made to the bits 20 and 21
> in pbpar, pbdir or pbodr. How does setting those bits enable the SMC2
> pins? Those are located in Port A (PA8 and PA9)
>
> I guess my point is why are the Port B registers being modified for SMC2
> pins which are found in Port A?

Oh oh......are you using an 823 or 850?  Sorry about this, you will
have to change the code.  Someday, I have to finish up a better UART
driver.  You are the first person I know that is trying to use this
as a UART.  SMC2 is the first thing to disappear when using the parts
for other data communication protocols or interfaces, so custom
software tends to assign these for other purposes.  I seldom see anything
but SMC1 used for a UART, so making the driver better hasn't been
high on the list......


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
