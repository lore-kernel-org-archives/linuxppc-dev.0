To: Sylvain Munaut <tnt@246tnt.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux on MPC5200 - LITE5200EVAL 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sat, 14 Feb 2004 12:59:08 +0100."
             <402E0D8C.4080801@246tNt.com>
Date: Sat, 14 Feb 2004 15:53:03 +0100
Message-Id: <20040214145308.9E915C108D@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <402E0D8C.4080801@246tNt.com> you wrote:
>
> The weird problem with u-boot ( not booting If I set bootargs manually )
> and the kernel crash are both solved. It was a compiler issue. I used a
> toolchain I used to build binaries for a "normal" mac based on gcc 3.4 (
> cvs ) and it was a really bad idea.

I see.

>  - The PCI slot is 3.3 v and apparently I don't have a single PCI card
> that seems to work on it ... When I plug one ( that I thought was 3.3v
> ), nothing boot, sometimes even the led don't power on ...

Be careful to put it correctly. The slot bracket has  to  be  on  the
side where the UART / USB / CAN connctors are. Do not insert the card
with the slot bracket pointing to the IDE connector.

Also be VERY carefully  which  card  you  insert.  make  sure  it  is
_really_ a 3.3V compatible card. [I fried a board by trying a Digitus
"DC  SER2 Rev. 2.0 Serial PCI I/O Card" - this card has the key slots
for a 3.3/5V combi card, but the V_I/O pins are connected to  the  5V
rail. The RAM chips didn't like to see 5V ...]

>  - When I change options in the kernel to support new stuff I need, like
> activating USB host & IDE controller, the kernel don't boot at all ( or
> at least, I don't see on the serial console it does ). It's the same
> problem with activating drivers for the PCI bus ... What is weird is
> that it's not an error on boot, it's just that after u-boot messages,
> there is nothing at all.

Can you attach a debugger? Or even try  a  post-mortem  dump  of  the
logbif area? Both PCI and USB are working fine for me.

> I'm not sure my hardware is fully OK, but I did mtest on u-boot  for
> about 10 hours and it didn't complained. It's a fresh new board from
> motorola...

Maybe you can ask for a replacement. Your problems don't look  normal
to me.

Best regards,

Wolfgang Denk

--
See us @ Embedded World, Nuremberg, Feb 17 - 19,  Hall 12.0 Booth 440
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Being schizophrenic is better than living alone.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
