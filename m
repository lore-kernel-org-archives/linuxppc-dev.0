Message-ID: <20020622030607.432.qmail@web21108.mail.yahoo.com>
Date: Fri, 21 Jun 2002 20:06:07 -0700 (PDT)
From: Tim Lai <laitingwai@yahoo.com>
Subject: Re: Can I run linux without a file system?
To: "Dr. Craig Hollabaugh" <craig@hollabaugh.com>,
	linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <3.0.3.32.20020621145425.006d0618@hollabaugh.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> >
> >Do I need to install all these files in the file
> >system? Can I have "/", with no file in it?
>
>
> What do you want to do? Do you want a shell, run a
> program, load a device driver? What is it exactly?
>

I 'll run my application which is build in the kernel.

No shell in the beginning. But I will need the shell
later when more NVRAM is available. With the hardware
that I have in the future, I can build my application
seperately and store it in the file system. The
application do some network processing, I'll not
have any display other then the console and maybe
telnet session.

Where or how do I get these lib for ppc?
         ./lib/ld.so.1
	./lib/libc-1.99.so
	./lib/libc.so.6
	./lib/libtermcap.so.2.0.8
	./lib/libtermcap.so.2

BTW, I just ordered the Dr.Hollabaugh's book.
Thanks for the advice.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
