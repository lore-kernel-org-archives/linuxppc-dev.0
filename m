To: jbeisert@eurodsn.de
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Debugging with BDI 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 18 Jul 2003 11:26:35 +0200."
             <200307181126.35714.jbeisert@eurodsn.de>
Date: Fri, 18 Jul 2003 12:07:44 +0200
Message-Id: <20030718100749.84AD2C6D82@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Jürgen,

in message <200307181126.35714.jbeisert@eurodsn.de> you wrote:
>
> I'm trying to debug my u-boot with BDI. It's a 405GP system.

This has nothing to do with Linux  and  is  thus  off  topic  on  the
linuxppc-embedded  mailing  list.  Please  post such questions to the
u-boot-users mailing list.


> In the telnet sessoin I can insert "reset run" and the u-boot starts. When I
> enter "reset halt" and then "go" it won't do anything. I have tried with ddd

What do you mean with "it won't do anything"? Who won't do  anything?
The  BDI2000?  The  CPU?  What  makes  you  think the CPU does not do
anything?


Are you sure your BDI2000 config file is OK for your board?  How  did
you  configure  "RESET  type"  and  "STARTUP  mode"?  Is  your "START
address" ok?


> When I step the mtmsr instruction ddd shows address 0x700, and the esr
> register has 0x8800'0000 (illegal instruction occured?????).
> Same when I place a breakpoint behind the mtmsr instruction und use "cont"
> instead of "stepi".

You  are  aware  that  you  cannot  single   step   through   certain
instructions, aren't you?

> What is the difference between "reset run" and "reset halt", "go"?

"reset run" and "reset halt" change the startup  mode  to  "run"  and
"halt",  respectively. "go" sets the PC and starts the target system.
Ummm.. is there any specific part where the BDI2000 manual is unclear
about this?


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
The computer can't tell you the emotional story. It can give you  the
exact mathematical design, but what's missing is the eyebrows.
- Frank Zappa

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
