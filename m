To: John Francis <johnfrancsis@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Interfacing user application and interrupt. 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sat, 21 Jul 2001 03:13:45 PDT."
             <20010721101345.5964.qmail@web20104.mail.yahoo.com>
Date: Sat, 21 Jul 2001 13:45:31 +0200
Message-Id: <20010721114536.EAE3010DD2@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20010721101345.5964.qmail@web20104.mail.yahoo.com> you wrote:
>
> I also have ppc linux interrupt handler that correctly
> detects the interrupt from the device. Now what I am
> missing is how does the kernel interrupt handler
> indicate to the user process that  there was an
> interrupt and user process needs to do its thing....

Either make your user process block in a read / write / ioctl  system
call,  and  wake  it  from  your  interrupt  handler,  or implement a
select() / poll() interface, so you don't have to block  waiting  for
this event alone.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
In C we had to code our own bugs, in C++ we can inherit them.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
