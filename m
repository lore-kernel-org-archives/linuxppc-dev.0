Return-Path: <sakurken@gmail.com>
Received: from mu-out-0910.google.com (mu-out-0910.google.com [209.85.134.185])
	by ozlabs.org (Postfix) with ESMTP id 93BC6DDEB7
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 23 Mar 2007 06:34:27 +1100 (EST)
Received: by mu-out-0910.google.com with SMTP id w9so1189445mue
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 22 Mar 2007 12:34:24 -0700 (PDT)
Message-ID: <393e3a4b0703221234n20eee581g6cbf9af9be2c5ebb@mail.gmail.com>
Date: Thu, 22 Mar 2007 14:34:24 -0500
From: "Ken Sakurai" <sakurken@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: AVNET 440GX board
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_111654_18274102.1174592064250"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_111654_18274102.1174592064250
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I'm trying to boot Linux on  AVNET 440gx eval board but no luck so far.
What I did are that I downloaded a plain 2.6.20 kernel from kernel.org,
configured with 440GX, OCOTEA target (I'm not sure OCOTEA is correct
target),
then loaded the kernel image via tftp  and tried to boot with bootelf
command.
But I had no output message from Linux.

I suspected setting of Linux serial console. So I changed the kernel
parameter to
"ttyS0,19200" which I suppose correct becuase this is the minicom setting.
But still didn't work.

The board comes with u-boot 1.0.2 with some fixes.  I'm checking the u-boot
source code (might be some hint in there) and the serial device
initialization code in Linux.

Has anyone had experiece with Linux on AVNET 440GX board?
Any advise would be appreciated !

-
Ken

------

=> tftp
Waiting for PHY auto negotiation to complete.. done
ENET Speed is 100 Mbps - FULL duplex connection
*** Warning: no boot file name; using '6501A8C0.img'
Using ppc_440x_eth2 device
TFTP from server 192.168.1.1; our IP address is 192.168.1.101
Filename '6501A8C0.img'.
Load address: 0x100000
Loading: #################################################################
         #################################################################
         #################################
done
Bytes transferred = 832121 (cb279 hex)
=> bootelf
Loading .text @ 0x01000000 (15316 bytes)
Loading .data @ 0x01004000 (700416 bytes)
Clearing .bss @ 0x010af000 (8500 bytes)
## Starting application at 0x01000000 ...

(no output after this message)

------=_Part_111654_18274102.1174592064250
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,<br><br>I&#39;m trying to boot Linux on&nbsp; AVNET 440gx eval board but no luck so far.<br>What I did are that I downloaded a plain 2.6.20 kernel from <a href="http://kernel.org">kernel.org</a>,<br>configured with 440GX, OCOTEA target (I&#39;m not sure OCOTEA is correct target),
<br>then loaded the kernel image via tftp&nbsp; and tried to boot with bootelf command.<br>But I had no output message from Linux.<br><br>I suspected setting of Linux serial console. So I changed the kernel parameter to <br>&quot;ttyS0,19200&quot; which I suppose correct becuase this is the minicom setting.
<br>But still didn&#39;t work.<br><br>The board comes with u-boot 1.0.2 with some fixes.&nbsp; I&#39;m checking the u-boot <br>source code (might be some hint in there) and the serial device <br>initialization code in Linux.<br>
<br>Has anyone had experiece with Linux on AVNET 440GX board? <br>Any advise would be appreciated !<br><br>-<br>Ken<br><br>------<br><br>=&gt; tftp<br>Waiting for PHY auto negotiation to complete.. done<br>ENET Speed is 100 Mbps - FULL duplex connection
<br>*** Warning: no boot file name; using &#39;6501A8C0.img&#39;<br>Using ppc_440x_eth2 device<br>TFTP from server <a href="http://192.168.1.1">192.168.1.1</a>; our IP address is <a href="http://192.168.1.101">192.168.1.101
</a><br>Filename &#39;6501A8C0.img&#39;.<br>Load address: 0x100000<br>Loading: #################################################################<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #################################################################
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #################################<br>done<br>Bytes transferred = 832121 (cb279 hex)<br>=&gt; bootelf<br>Loading .text @ 0x01000000 (15316 bytes)<br>Loading .data @ 0x01004000 (700416 bytes)<br>Clearing .bss @ 0x010af000 (8500 bytes)
<br>## Starting application at 0x01000000 ...<br><br>(no output after this message)<br>

------=_Part_111654_18274102.1174592064250--
