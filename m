Message-ID: <39215F00.D73562C3@motorola.com>
Date: Tue, 16 May 2000 09:45:20 -0500
From: "Richard Hendricks" <richard.hendricks@motorola.com>
MIME-Version: 1.0
To: "Dan A. Dickey" <ddickey@charter.net>
CC: "linuxppc-embedded@lists.linuxppc.org"  <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: How to get rom code to go on FADS?
References: <391B220F.9838E70F@charter.net> <391C3273.4BBF0884@motorola.com> <391C3945.9E0A439F@charter.net> <391C5416.15ADA181@motorola.com> <391D5E99.D14A02F2@charter.net> <39201DD2.2135361E@motorola.com> <39202D2C.385DD3B@charter.net> <3920AA9F.2DCA0B2E@charter.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


"Dan A. Dickey" wrote:
>
> Ok, I've backed out your change, and am now or'ing in the 16.
> Things work again.  Well; the signal lamp goes on & off.
> Checking the fads users manual, the address of BCSR1 is clearly
> at 02100010.  Perhaps you were thinking of word addresses or something?
>
> And, I'm currently still stuck at the development port interrupt...
>         -Dan

Doh, I thought you were using the IrDA LED.  Nevermind. 0x10 is correct.

--
MPC823 Applications Engineering Development
Get help from other MPC823 customers on the
comp.sys.powerpc.tech newsgroup!

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
