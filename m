Message-ID: <397D9E3B.51E31B0E@ivey.uwo.ca>
Date: Tue, 25 Jul 2000 10:03:39 -0400
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
MIME-Version: 1.0
To: tom_gall@vnet.ibm.com
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: diff to tonight's kaffe cvs tree to work on ppc
References: <200007250345.VAA22028@faith.cs.utah.edu> <397D926F.111AF60E@ivey.uwo.ca> <397D9744.31E6BDC6@vnet.ibm.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Tom,

Good to hear from you again!

>   This is only true as far as the 64 bit systems running on the 32 bit kernel,
> which is all there is at the moment.

I am confused.  Which of the following is true on a 64 bit system running on a
32 bit kernel?

A).  sizeof(unsigned int) > sizeof(void *)

or

B). sizeof(unsigned int) < sizeof(void *)

If A) is true, then my stack alignment macro will still work.  If B) is true, I
am in trouble.

>   Work has started on the 64 bit PowerPC Linux kernel, if Kaffe is compiled as a
> 64 bit app for that kernel then sizeof(unsigned long) = sizeof(void *) will be
> true. Certainly not a big deal at this stage, but thought you'd be interested
> none the less.

Sounds good!  When IBM is ready to start giving 64bit systems to help
developers, let me know! ;-)

Take care,

Kevin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
