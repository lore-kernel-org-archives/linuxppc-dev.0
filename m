Message-ID: <3E5CE518.7030001@devcom.cz>
Date: Wed, 26 Feb 2003 17:02:32 +0100
From: Jan Damborsky <jan.damborsky@devcom.cz>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: X windows for Linux PPC embedded
References: <301A812E6528D511A8F70008C71E578601D3401F@AP-BANG-M02>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


g.ramakrishna@exgate.tek.com wrote:

 >>I would like to ask, if there is some project
 >>for porting X windows system to Embedded
 >>PPC Linux. I use board with MPC823E with
 >>VGA TFT display+touch screen, 32MB RWM,
 >>4MB FLASH, Ethernet, serial RS232,....
 >>I would like to use it as remote graphic terminal
 >>communicating via Ethernet by means of X protocol.
 >>Does somebody know how to make it work ?
 >>
 >>
 >
 >
 >There is nothing much to port.  Few months back I had cross-compiled TinyX
 >successfully for a MPC860 board on x86 platform.
 >Except the proprietary touch screen interface(we added this ourself),
 >everything else worked fine on the target framebuffer device.  But I
haven't
 >tried the complete X.
 >I hope this information is useful for you.
 >
 > regards,
 >Ramakrishna, G
 >
 >
 >
Thank you for your information. We have 32M of DRAM, 16M of FLASH on board.
Do you think it is sufficient for make tinyX working?

                 HANYS


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
