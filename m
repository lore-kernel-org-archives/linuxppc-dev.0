Message-ID: <37D0F88E70D96C428C19EEB865701A38EBCD1C@buda902a.siemens.hu>
From: =?ISO-8859-1?Q?M=E9sz=E1ros_Lajos?= <ludwigm@siemens.hu>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: real time clock seems stuck!
Date: Wed, 12 Jun 2002 08:56:27 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


zhongqx wrote:

>     I use SMC2 for Console,this time message come from SMC2,but it has
warning message
> like following:
> warning: Real time clock seems stuck, then it is dead!
> it seems calibrate_delay() function can not go forward(perhaps), Do you
know why?
> Should I add CONFIG_RTC?

IF it comes from PpcBoot AND your kernel is after 2.4.5
THEN unconfig CONFIG_CLOCKS_IN_MHZ in PpcBoot. (the kernel requires Hz but
get MHz)

The "Real time clock seems stuck" warning remains, but calibrate_delay()
goes on.

Ludwig

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
