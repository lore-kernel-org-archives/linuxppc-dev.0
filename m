Message-ID: <3DA5A858.50802@embeddededge.com>
Date: Thu, 10 Oct 2002 12:18:32 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: joakim.tjernlund@lumentis.se
Cc: Barker Michael-r43496 <Michael.D.Barker@motorola.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: 8xx i2c refers to unspecified chip errata
References: <IGEFJKJNHJDCBKALBJLLIEPPFGAA.joakim.tjernlund@lumentis.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Joakim Tjernlund wrote:

 > .... The driver(i2c-algo-8xx.c) that
> comes with the kernel has other severe bugs(memory corruption etc.) as well.

Just toggle the bits in software.  I never saw an application where the I2C
controller provided a performance advantage.  It's lots of software to execute,
along with all of the interrupt handling and stuff, so you just spend lots of
overhead not making any other progress.

Make sure you carefully analyze the entire system performance advantages.
Using the controller assitance just because it is there isn't always the
proper solution.  Same is true for the SPI.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
