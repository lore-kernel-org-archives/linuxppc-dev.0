Return-Path: <nielsen.esben@gogglemail.com>
Date: Tue, 19 Sep 2006 14:16:07 +0200 (CEST)
From: Esben Nielsen <nielsen.esben@gogglemail.com>
To: Josu Onandia <jonandia@fagorautomation.es>
Subject: Re: Measure Interrupt Latency on MPC5200B
In-Reply-To: <450FDCFD.9040102@fagorautomation.es>
Message-ID: <Pine.LNX.4.64.0609191414090.10784@frodo.shire>
References: <ac3922a00609140500j79e33fb3lfecbefc151ce3b41@mail.gmail.com>
	<450FDCFD.9040102@fagorautomation.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
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

On Tue, 19 Sep 2006, Josu Onandia wrote:

> Syed Amer Gilani wrote:
>
>> We have a MPC5200B(ppc) Board from Phytec, running with a 2.6 Linux
>> Kernel. For Documentation purposes and testings how patches to the
>> Kernel affects real time capabilities we want to measure the Interrupt
>> Latency.
>> I only found tools for other arches or patches for far to old kernels.
>> Does somebody know a way for a 2.6 kernel on ppc? I already thought of
>> generating a signal on an Output of the Board and measure it with a
>> Oscilloscope but i don't find that method satisfying.
>>
>> Thank you in advance,
>> Syed Amer Gilani
>> _______________________________________________
>> Linuxppc-embedded mailing list
>> Linuxppc-embedded@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>>
>>
> Hi. I'm sorry for my own latency, but I've been very busy.
>
> I'm measuring interrup latency in an MPC5200B, too, but with Linux 2.4.
>
> With this processor you can use the TB registers to measure a lapse of time.
>
> I use a GPT timer to generate a periodic interrupt. From the interrupt
> routine I read the TBL and compare it with the expected value.
>
> I do this using RTAI, because I need real-time response to interrupts,
> but I suppose that with little effort you can port it to standard Linux.
>
> If you want more details, or my actual source code, email me.
>
> Josu Onandia
>
>

What are your results under the normal kernel and under RTAI?
Have anyone tried with -rt kernels? What are the results?

I work for a company using MPC5200 with VxWorks. It could be fun to 
compare numbers...

Esben
