Subject: Re: 8xx i2c refers to unspecified chip errata
In-Reply-To: <3DA5A858.50802@embeddededge.com>
To: Dan Malek <dan@embeddededge.com>
Date: Thu, 10 Oct 2002 10:35:42 -0600 (MDT)
Cc: joakim.tjernlund@lumentis.se,
	Barker Michael-r43496 <Michael.D.Barker@motorola.com>,
	linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20021010163542.A6F4027C52@chuy.ouraynet.com>
From: craig@hollabaugh.com (Dr. Craig Hollabaugh)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Joakim Tjernlund wrote:
>
>  > .... The driver(i2c-algo-8xx.c) that
> > comes with the kernel has other severe bugs(memory corruption etc.) as well.
>

Dan Wrote
> Just toggle the bits in software.  I never saw an application where the I2C
> controller provided a performance advantage.  It's lots of software to execute,
> along with all of the interrupt handling and stuff, so you just spend lots of
> overhead not making any other progress.
>
> Make sure you carefully analyze the entire system performance advantages.
> Using the controller assitance just because it is there isn't always the
> proper solution.  Same is true for the SPI.


Here's a link to my book's I2C bit banging code for 8xx
http://www.embeddedlinuxinterfacing.com/chapters/10/SAA1064_rpxcllf.c

You can pull the I2C routines from this code.

Let me know if you have any questions.
Craig


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
