Message-ID: <3C67E711.2108C6DD@ardistech.com>
Date: Mon, 11 Feb 2002 16:45:21 +0100
From: "bart@ardistech.com" <bart@ardistech.com>
Reply-To: bart@ardistech.com
MIME-Version: 1.0
To: Dan Malek <dan@embeddededge.com>
Cc: Alex Zeffertt <ajz@cambridgebroadband.com>,
	Embedded Linux PPC List <linuxppc-embedded@lists.linuxppc.org>,
	dmalek@jlc.net
Subject: Re: MPC823: i2c-algo-8xx read interrupt?
References: <3C63EC39.ACEECA08@ardistech.com> <3C640532.5000708@embeddededge.com> <3C640C11.4080407@cambridgebroadband.com> <3C6776CC.634AB65D@ardistech.com> <3C67E38C.2020304@embeddededge.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek wrote:

>
> How do you know when you have received the proper number of bytes?  Are we
> always changing the value of mrblr (I don't remember the code anymore)?
>
I knew about the TX counter being used for the number of RX'd bytes, but expected
the RX interrupt to be the last one, after the RX buffer was closed (This often
seems to be the case, as long as the RX interrupt does not dissapear).

>
> You could just poll the receive buffer for about two plus a little character
> times.  If you don't get the empty flag cleared in this time report some error.
>
I think that's the best solution.

> The interesting thing about any I2C controller is the overhead of trying to
> manage this thing is higher than just clocking bits in software.  I seldom
> use the I2C controller, just a few lines of C code to do the job. Think about it.
>
You're right, but spending XX$ on a fast PPC chip and after that let it run
busy loops to time the I2C control makes me feel bad :)

	Bart

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
