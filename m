Message-ID: <40C42D10.5030308@intracom.gr>
Date: Mon, 07 Jun 2004 11:53:36 +0300
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
Cc: Tom Rini <trini@kernel.crashing.org>,
	Kumar Gala <kumar.gala@motorola.com>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: [PATCH] Take two of the new serial uart driver.
References: <40BF3206.8030705@intracom.gr>	 <1086426744.4588.121.camel@imladris.demon.co.uk>	 <20040605192221.GT15195@smtp.west.cox.net>	 <1086472929.4862.12.camel@localhost.localdomain>	 <40C42337.20209@intracom.gr>	 <1086597379.29255.13.camel@localhost.localdomain>	 <40C428AD.8020707@intracom.gr> <1086598392.29255.15.camel@localhost.localdomain>
In-Reply-To: <1086598392.29255.15.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David Woodhouse wrote:

>On Mon, 2004-06-07 at 11:34 +0300, Pantelis Antoniou wrote:
>
>>Hmm, just multiply by 3 in udelay instead of 2.
>>
>>What is your baud rate? 9600?
>>
>
>Yeah. Why must we pick numbers out of the air instead of actually
>waiting for the hardware to say it's finished?
>
>
Actually I didn't pick it out of thin air.

It is mentioned in the manual that you must wait
two character times for the HW fifo to drain.
There is no hardware event bit for FIFO empty.

It's just that the udelay call is not really exact.
So +1 and we're all OK! :)

So did it work now?

Regards

Pantelis


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
