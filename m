Message-ID: <3FF8E408.8060507@kegel.com>
Date: Sun, 04 Jan 2004 20:11:52 -0800
From: Dan Kegel <dank@kegel.com>
MIME-Version: 1.0
To: sun-zj <sun-zj@tdk-tech.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: cant't stop program
References: <200401050235.UAA05095@lists.linuxppc.org>
In-Reply-To: <200401050235.UAA05095@lists.linuxppc.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


sun-zj wrote:
> After the denk's instruction, I can run the
> linuxppc-2.4.23 on PPC8xx without too much difficulty. But when running some
> programming , I want to terminate it like I do on PC by press Ctrl+C.
> It doesn't work at all :(. It can work under the U-boot environment. I
> wonder whether this is the
> problem of Linux os Or Kermit?

I have seem problems like that when running from serial
console under Busybox.  I think busybox's init is buggy.
Does the problem happen when you telnet in from another computer,
or only on a serial console?
- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
