Message-ID: <399D6E54.B211AB8E@mvista.com>
Date: Fri, 18 Aug 2000 10:11:48 -0700
From: Matthew Locke <mlocke@mvista.com>
MIME-Version: 1.0
To: Paolo Scaffardi <arsenio@tin.it>
CC: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Porting X to PowerPC platform
References: <002501c008fc$d8938060$020a0a0a@PaoloScaffardi>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Paolo Scaffardi wrote:
>
> I am writing a framebuffer device for my MPC823FADS platform, and i need to
> port a simple X-server based on the framebuffer to my PowerPC.

nothing in X is ever simple :-)

>
> I looked at the XFree86 sources but it's not clear hot to compile them for
> PowerPC targets!

I guess size is not important for you.  We (Montavista) are supporting
Microwindows, which is a small footprint open-source windowing system
for embedded systems (I must have said this a thousand times at
LinuxWorld).  you can find a srpm and a rpm for 8xx on our ftp site
ftp://ftp.mvista.com.  It is very light weight, but has several widgets
(listbox, buttons, etc).

> Are you already done this?
> How can i proceed?
>
> I'm in a hurry... please help me soon!
>
yeah, if you are in a hurry, I suggest trying microwindows. It has both
a Win323 API and a "X like" API into its graphics engine.  If you are
familiar with either one, you can have a simple app running in no time.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
