To: Jean-Denis Boyer <jdboyer@mediatrix.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: BDI2000 on an 8250 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 26 Jul 2002 11:07:33 EDT."
             <2702075D4DE2B043BF5EB82E9CFAD45B093B1E@mail1.mediatrix.com>
Date: Fri, 26 Jul 2002 17:27:44 +0200
Message-Id: <20020726152749.932CA10876@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Jean-Denis,

in message <2702075D4DE2B043BF5EB82E9CFAD45B093B1E@mail1.mediatrix.com> you wrote:
>
> It works very well on my custom board with an 8260 (HIP3). We prepared an
> identical board with an 8250 (HIP4) (with the required modifications), but I
> have problems executing helper code out of it. It almost always hangs with
> the message "PPC: timeout while waiting for freeze"... sometimes (rarely) it
> works. The software on it (kernel 2.4.19-rc2) works very well. No one could
> help me at Abatron (the issue is still pending), since apparently, nobody
> use that processor yet. The only answer I got is that an 8260A is supported
> (and was tested), and for COP debugging, it is the same thing.

I can confirm that it works fine on 8260, for example on the TQM8260:

PPCBoot 1.1.6 (Apr 28 2002 - 20:22:57)

MPC8260 Reset Status: External Soft, External Hard

MPC8260 Clock Configuration
 - Bus-to-Core Mult 3.5x, VCO Div 2, 60x Bus Freq  30-85 , Core Freq 100-300
 - dfbrg 0, corecnf 0x1e, busdf 4, cpmdf 1, plldf 1, pllmf 4
 - vco_out  416665000, scc_clk  104166250, brg_clk  104166250
 - cpu_clk  291665500, cpm_clk  208332500, bus_clk   83333000

CPU:   MPC8260 (Rev 14, Mask A.0(A) 2K25A) at 291.665 MHz
Board: TQM8260DBA0C7A-PJDA.201A 10399642 6

Haven't seen a 8250 yet, though.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"Data is a lot like humans: It is  born.  Matures.  Gets  married  to
other  data, divorced. Gets old. One thing that it doesn't do is die.
It has to be killed."                                 - Arthur Miller

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
