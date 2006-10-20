Return-Path: <frannk_m1@yahoo.com>
Received: from web32203.mail.mud.yahoo.com (web32203.mail.mud.yahoo.com
	[68.142.207.134]) by ozlabs.org (Postfix) with SMTP id C83AA67B6C
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 20 Oct 2006 15:29:12 +1000 (EST)
Message-ID: <20061020042910.58138.qmail@web32203.mail.mud.yahoo.com>
Date: Thu, 19 Oct 2006 21:29:10 -0700 (PDT)
From: Frank <frannk_m1@yahoo.com>
Subject: Re: u-boot question
To: Lei Sun <leisun124@gmail.com>, linuxppc-embedded@ozlabs.org
In-Reply-To: <f9a7e7a80610192058s34584559g4a4e02abb50829e2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



--- Lei Sun <leisun124@gmail.com> wrote:

> Hi all:
>   Is this the right list to ask for U-BOOT related question?
> If it's
> not, please igore it and direct me to the right list.
>   I am trying to bring up a custom designed board based on
> MPC8270,
> after spent 3 weeks on fixing hardware issues (extreme surgery
> !) , I
> finally be able to read something out of the flash and
> verified SDRAM
> is working as well. Up to this point our JTAG debugger is
> dead! I
> burned u-boot Image using a programmer and put it in. after
> power up
> and did a PORESET, I found out that every 20 seconds or so ,
> system
> generated HRESET,( by measuring the HRESET pin of the JTAG
> port). It
> does read Hardware Reset Config Word when reset happens (I saw
> pulse
> on the CS0 pin).  Before the JTAG die, i was able to issue
> "reset"
> command through it and found out the PC stays at 0x100,  but
> issue
> "go" command , the PC became 0x000000fc and hangs.
>   My questions are :
> 1. What's the best way to verify that CPU read correct HRCW ?
> 2. Any good JTAG debugger for this family of CPU you can
> recommend ?
> We bought Gaurdian-SE from etoolsmith (the company no longer
> exsit!)
> which really sucks!

Buy a Abatron BDI2000...

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
