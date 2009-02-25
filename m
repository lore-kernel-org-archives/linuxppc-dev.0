Return-Path: <galak@kernel.crashing.org>
Message-Id: <19A971C7-A024-4315-993E-3253BDE7094A@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Mark Bishop <mark@bish.net>
In-Reply-To: <20090224201936.jlryqrul6owwc0sg@www.bish.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: Freescale MPC8313 & SPI
Date: Wed, 25 Feb 2009 08:22:37 -0600
References: <20090224201936.jlryqrul6owwc0sg@www.bish.net>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 24, 2009, at 7:19 PM, Mark Bishop wrote:

> I am trying to understand more about how to talk to different spi  
> chips using the MPC8313.  The documentation that comes with the  
> development board is really lacking and I am relying on the /usr/src/ 
> linux/Documentaion/spi.  However, I still can't seem to answer my  
> questions.
>
> 1) Which device do I open up to talk to the bus.  I would use  
> something like /dev/ttyS0 for a serial port, and I assume it would  
> be /dev/spidev.0 and I would have to make it manually using mknod -  
> but what ties the /dev/spidev.0 to the actual chip driver?  Is there  
> something I have to do in addition to mknod?
>
> 2) I would be looking for a few examples on how to talk to a SPI bus  
> as well.  I've looked at spidev_test.c and I would like to see  
> another example or two.

This question might be better asked on the spi-devel list.

https://lists.sourceforge.net/lists/listinfo/spi-devel-general

- k
