To: Charles Lockhart <lockhart@jeans.ifa.hawaii.edu>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux on the Virtex II Pro?- ELDK? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 10 Jul 2003 15:02:09 -1000."
             <3F0E0C91.1000209@irtf.ifa.hawaii.edu>
Date: Fri, 11 Jul 2003 09:00:18 +0200
Message-Id: <20030711070023.8F270C6D82@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3F0E0C91.1000209@irtf.ifa.hawaii.edu> you wrote:
>
> Is it possible to use the ELDK to compile a simple stand alone
> executable that I could download and start using my jtag interface?  I

Yes, of course tis is possible. We use the ELDK for example to  build
the  U-Boot  boot  loader on a plethora of systems - which is nothing
else but a (bigger) standalone executable.

You will have to be careful about assumptions about:
- C runtime envrionment (there is none, or you have to set it up yourself)
- library usage (standard C libs require full C runtime envrionment
  plus some other things like standard file descriptors, etc.)

Feel free to have a look at U-Boot...

> tried compiling a really trivial piece of code with the "-static"
> option, and it created a file that looks large enough to have included
> everything it needs but when I download and start it, I don't see any of
> the break points I'm setting being triggered.

How did you set up your C runtim environment, for example: allocate a
stack, initialize the "parent" stack frame, etc. ?


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Once at a social gathering, Gladstone said to Disraeli,  "I  predict,
Sir,  that  you  will die either by hanging or of some vile disease".
Disraeli replied, "That all depends, Sir, upon whether I embrace your
principles or your mistress."

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
