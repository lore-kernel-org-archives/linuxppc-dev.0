Message-ID: <402E633A.2040009@246tNt.com>
Date: Sat, 14 Feb 2004 19:04:42 +0100
From: Sylvain Munaut <tnt@246tnt.com>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux on MPC5200 - LITE5200EVAL
References: <20040214145308.9E915C108D@atlas.denx.de>
In-Reply-To: <20040214145308.9E915C108D@atlas.denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi

>> - The PCI slot is 3.3 v and apparently I don't have a single PCI card
>>that seems to work on it ... When I plug one ( that I thought was 3.3v
>>), nothing boot, sometimes even the led don't power on ...
>>
>>
>
>Be careful to put it correctly. The slot bracket has  to  be  on  the
>side where the UART / USB / CAN connctors are. Do not insert the card
>with the slot bracket pointing to the IDE connector.
>
>Also be VERY carefully  which  card  you  insert.  make  sure  it  is
>_really_ a 3.3V compatible card. [I fried a board by trying a Digitus
>"DC  SER2 Rev. 2.0 Serial PCI I/O Card" - this card has the key slots
>for a 3.3/5V combi card, but the V_I/O pins are connected to  the  5V
>rail. The RAM chips didn't like to see 5V ...]
>
>
Yeah I can only imagine ...
I don't think my only test fried the card, it show the same behavior
before and after so I guess ( hope ? ) I'm lucky.

The slot does indeed work, I just came across a Intel EEPro100 card,
like the one I used on other dev kit. I'm sure it's 3.3v/5v compatible
and it's recognized without problems.

>> - When I change options in the kernel to support new stuff I need, like
>>activating USB host & IDE controller, the kernel don't boot at all ( or
>>at least, I don't see on the serial console it does ). It's the same
>>problem with activating drivers for the PCI bus ... What is weird is
>>that it's not an error on boot, it's just that after u-boot messages,
>>there is nothing at all.
>>
>>
>
>Can you attach a debugger? Or even try  a  post-mortem  dump  of  the
>logbif area? Both PCI and USB are working fine for me.
>
>
I don't have a debugger ... But I think I'll invest in one soon ! ;)
How can I dump the logbuf area ? I saw a discussion on this ml about
this buffer, is it fixed in memory ? How to find it's address ?

>>I'm not sure my hardware is fully OK, but I did mtest on u-boot  for
>>about 10 hours and it didn't complained. It's a fresh new board from
>>motorola...
>>
>>
>
>Maybe you can ask for a replacement. Your problems don't look  normal
>to me.
>
>
>
Could you send me a kernel image you compiled with the config at
http://www.246tNt.com/mpc5200_config ?
Maybe my compiler is wrong again. The ELDK binaries didn't work ( I
don't have the good glibc version on my machine ). I'm downloading what
I need to try to compile it right now ...
I've also put http://www.246tNt.com/uImage wich is not bootable on my
board ...

Basically the config is default + USB + IDE ( HD & CDRom ) + SCSI disk
support ( for memory sticks on USB ) + Misc filesystems and partition
support.

On http://www.246tNt.com/mpc5200_config  is a sample .config file that
makes the kernel to not boot at all.


Sylvain Munaut


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
