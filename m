To: Jim Rowe <rowejames@acmsystems.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MPC8250 + PCMCIA + airo_cs card + IO Port mapping proble 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "23 May 2003 15:14:34 PDT."
             <1053728074.29793.30.camel@kneedragger>
Date: Sat, 24 May 2003 00:44:33 +0200
Message-Id: <20030523224438.9E1B7C6162@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <1053728074.29793.30.camel@kneedragger> you wrote:
>
> If anyone has a 16-bit pcmcia card working with a Cardbus to PCI bridge
> it would be very helpful if I could see your /proc/ioports and
> /proc/iomem with the card working. It would be even better if you are
> using an MPC82xx chip with an integrated PCI controller.

This is on  a  MPC8250  system  (ATC  board  in  U-Boot  and  in  our
linuxppc_2_4_devel  tree).  There  is  a  compact  flash  card  on it
attached to an Intel 82365 and PC Card controller.

bash-2.05# cat /proc/ioports
bash-2.05# cat /proc/iomem
00000000-ffffffff : <BAD>
  80000000-80000fff : PCI device 104c:ac56 (Texas Instruments)
    80000000-80000fff : i82365
  81000000-81000fff : card services

As you can see, we use the standard PCMCIA Card Services package.

Hope this helps.


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
A direct quote from the Boss: "We passed over a lot of good people to
get the ones we hired."

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
