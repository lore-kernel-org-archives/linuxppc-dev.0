To: "Jack Liu" <Jack_liu@usish.com>
Cc: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Sandpoint problems 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 16 Feb 2004 08:51:42 +0800."
             <200402160051.i1G0pKqA003808@ms.usish.com>
Date: Mon, 16 Feb 2004 10:35:14 +0100
Message-Id: <20040216093519.B09DEC1096@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <200402160051.i1G0pKqA003808@ms.usish.com> you wrote:
>
>   I am planning to use U-Boot to replace DINK13 shipped in Sandpoint
> platform. I got a sucessful compilation by: Make Sandpoint8245_config,
> Make all . Then I Burn u_boot.src in the Boot ROM. IT CAN'T BOOT. I used
> all default setting in the PrPMC8245 and Sandpoint board. I didn't know
> the reason. Anybody knows?

First, this is off topic on the linuxppc-embedded list.  Please  send
U-Boot related questions to the u-boot-users list. Thanks.

What exactly did you do?  "I  Burn  u_boot.src"?  There  is  no  file
u_boot.src.  Do  you  mean  u_boot.srec? Note that this is a S-Record
file - are you sure you need to use the S-record file?

Where exactly in flash did you program it? How did  you  verify  that
the flash programming worked?


And what exactly do you mean by "it can't  boot"?  (An  why  are  you
shouting?) Is the board completely dead? Is there Some output? Which?
Does U-Boot run, but fails to boot Linux? Or what?

Best regards,

Wolfgang Denk

--
See us @ Embedded World, Nuremberg, Feb 17 - 19,  Hall 12.0 Booth 440
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
After Goliath's defeat, giants ceased to command respect.
- Freeman Dyson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
