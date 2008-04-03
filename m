Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id C546ADDD04
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Apr 2008 04:41:29 +1100 (EST)
From: Gabriel Paubert <paubert@iram.es>
Date: Thu, 3 Apr 2008 19:41:23 +0200
To: mejjad lahcen <lmejjad@gmail.com>
Subject: Re: interrupt latency spi
Message-ID: <20080403174123.GA25888@iram.es>
References: <9b4863980804030609s3ff05c33g462ffc1769546010@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9b4863980804030609s3ff05c33g462ffc1769546010@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 03, 2008 at 09:09:04AM -0400, mejjad lahcen wrote:
>  hi all of you ,
> I am wndering if someone has already done test for interrupt latency on
> linx 2.6.23 mpc5200b.
> I am working on writing a driver which is get SPi involved on design, and I
> know that the  spi interrupt will occurs at every 2 us ( speed 4 MHz
> interupt occurs when It recieves on bytes) so  I am worring about interrupt
> latency.

Expecting to be able to handle an interrupt every 2 microseconds is
simply crazy. Your hardware should at least have some FIFO to buffer
the data, hey, that's what UART started doing even at much lower bit
rates...

	Gabriel
