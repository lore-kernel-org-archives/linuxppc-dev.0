Message-ID: <3E5CE502.4050307@devcom.cz>
Date: Wed, 26 Feb 2003 17:02:10 +0100
From: Jan Damborsky <jan.damborsky@devcom.cz>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: X windows for Linux PPC embedded
References: <20030224214813.6D2FAC6E0C@atlas.denx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wolfgang Denk wrote:

 >In message <3E5A528A.4020805@devcom.cz> you wrote:
 >
 >
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
 >There is nothing much to "port". Just use a system with  as  much  as
 >possible RAM, and a local harddisk, so you can enable swap space, and
 >run the standard "make" procedure on the target (native!).
 >
 >I once looked into this trying to find out if you could prepare X11R6
 >for cross compilation, but found it too difficult  /  not  worth  the
 >effort.  I  ran  a  build  on  a  MPC860P  with 64 MB RAM and a 20 GB
 >harddisk attached to the PCMCIA slot. It took  _ages_  (>  48  hours,
 >IIRC)  but  except  for  some  minor issues the build went through. I
 >think this was in the  age  of  HHL  1.2  JE,  so  any  decent  build
 >environment should work fine, too.
 >
 >
 >Best regards,
 >
 >Wolfgang Denk
 >
 >
 >
Thank you for information,  HANYS


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
