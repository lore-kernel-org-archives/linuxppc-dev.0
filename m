Date: Tue, 25 May 1999 12:00:36 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Andreas Tobler <a.tobler@schweiz.ch>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: ATI-chip in PowerbookG3
In-Reply-To: <374413A8.E8E74F85@schweiz.ch>
Message-ID: <Pine.LNX.4.10.9905251159460.32176-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 20 May 1999, Andreas Tobler wrote:
> I want to find out if my ATI chip is supported by the atyfb driver. The
> things I can find are the following:
> Powerbook Wallstreet G3 from June 98 250MHz 13.1 TFT 96MB Ram
> System Profiler output:
> Card Name:      ATY,264LT-G
> Card Model:     ATY,LT-G
> Card Rom:       113-XXXXX-1.0028
> Card Revision:  128
> Card Vendor ID  1002
> Slot $E1
> 
> When I have a look into the file atyfb.c I see the following:
> static struct aty_features {
>     u16 pci_id;
>     u16 chip_type;
>     const char *name;
> } aty_features[] __initdata = {

    [...]

>     { 0x4c47, 0x4c47, "3D RAGE LT PRO" },

    [...]

> };
> Sorry for the length..
> 
> Which of the devices above corresponds to my PB chip? 
> 
> My kernels come up with the following message:
> 
> MacOS display is /pci/ATY,264LT-G
> atyfb: 3D RAGE LT PRO [0x4c47 rev 0x80] 4M SGRAM, 230 MHz PLL, 63 Mhz
         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> MCLK
> Console: switching to colour frame buffer device 128x48
> fb0: ATY Mach64 frame buffer device on /pci/ATY,264LT-G 
       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Greetings,

						Geert

--
Geert Uytterhoeven                     Geert.Uytterhoeven@cs.kuleuven.ac.be
Wavelets, Linux/{m68k~Amiga,PPC~CHRP}  http://www.cs.kuleuven.ac.be/~geert/
Department of Computer Science -- Katholieke Universiteit Leuven -- Belgium


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
