Return-Path: <jonandia@aotek.es>
Message-ID: <450FDCFD.9040102@fagorautomation.es>
Date: Tue, 19 Sep 2006 14:05:17 +0200
From: Josu Onandia <jonandia@fagorautomation.es>
MIME-Version: 1.0
To: Syed Amer Gilani <amg@systec.de>
Subject: Re: Measure Interrupt Latency on MPC5200B
References: <ac3922a00609140500j79e33fb3lfecbefc151ce3b41@mail.gmail.com>
In-Reply-To: <ac3922a00609140500j79e33fb3lfecbefc151ce3b41@mail.gmail.com>
Content-Type: text/plain;
	charset=ISO-8859-1;
	format=flowed
Cc: Linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Syed Amer Gilani wrote:

>We have a MPC5200B(ppc) Board from Phytec, running with a 2.6 Linux
>Kernel. For Documentation purposes and testings how patches to the
>Kernel affects real time capabilities we want to measure the Interrupt
>Latency.
>I only found tools for other arches or patches for far to old kernels.
>Does somebody know a way for a 2.6 kernel on ppc? I already thought of
>generating a signal on an Output of the Board and measure it with a
>Oscilloscope but i don't find that method satisfying.
>
>Thank you in advance,
>Syed Amer Gilani
>_______________________________________________
>Linuxppc-embedded mailing list
>Linuxppc-embedded@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>  
>
Hi. I'm sorry for my own latency, but I've been very busy.

I'm measuring interrup latency in an MPC5200B, too, but with Linux 2.4.

With this processor you can use the TB registers to measure a lapse of time.

I use a GPT timer to generate a periodic interrupt. From the interrupt 
routine I read the TBL and compare it with the expected value.

I do this using RTAI, because I need real-time response to interrupts, 
but I suppose that with little effort you can port it to standard Linux.

If you want more details, or my actual source code, email me.

Josu Onandia
