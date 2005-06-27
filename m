Return-Path: <ma.jianjie@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.194])
	by ozlabs.org (Postfix) with ESMTP id 4EFEA67B67
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 27 Jun 2005 13:41:08 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id i5so290512wra
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 26 Jun 2005 20:41:07 -0700 (PDT)
Message-ID: <45d67d710506262041722dab8f@mail.gmail.com>
Date: Mon, 27 Jun 2005 11:41:06 +0800
From: "signal@embedworld" <ma.jianjie@gmail.com>
To: linuxppc-embedded@ozlabs.org
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_878_12092704.1119843666844"
Subject: ppc32: problems boot the Linux for SBS/K2 board.
Reply-To: "signal@embedworld" <ma.jianjie@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_878_12092704.1119843666844
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,=20
We had a SBS/K2 board,which had an IBM PowerPC 750 processor with cPCI=20
interface. The old kernel on the boards worked quite well with Vxworks BSP=
=20
and Linux 2.4.2 kernel. But it failed to boot with the new kernel version=
=20
2.6.8(I had tested other versions too). Here is the message I got from the=
=20
HyperTerminal.

-------------------------------------------------------------
Attaching to ATA disk device... done.
Loading /ata0/tftpboot/zImage.elf...1425876
Starting at 0x800000...

id mach(): done
MMU:enter

MMU:hw init

hash:enter

hash:find piece

hash:patch

hash:done

MMU:mapin

MMU:setio

MMU:exit

setup_arch: enter

setup_arch: bootmem

arch: exit

-----------------------------------

What's the problems of these failure?

Does anybody here had succeeded booting the 2.6 kernel for SBS/K2 boards?

Thanks in advanced!

Jianjie Ma
2005.6.27

------=_Part_878_12092704.1119843666844
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<p>Hi, <br>&nbsp;&nbsp;&nbsp; We had a SBS/K2 board,which had an IBM PowerP=
C 750 processor with cPCI interface. The old kernel on the boards worked qu=
ite well with Vxworks BSP and Linux 2.4.2 kernel. But it failed to boot wit=
h the new kernel version=20
2.6.8(I had tested other versions too). Here is the message I got from the =
HyperTerminal.<br>&nbsp;<br>-----------------------------------------------=
--------------<br>Attaching to ATA disk device... done.<br>Loading /ata0/tf=
tpboot/zImage.elf...1425876
<br>Starting at 0x800000...</p>
<p>id mach(): done<br>MMU:enter</p>
<p>MMU:hw init</p>
<p>hash:enter</p>
<p>hash:find piece</p>
<p>hash:patch</p>
<p>hash:done</p>
<p>MMU:mapin</p>
<p>MMU:setio</p>
<p>MMU:exit</p>
<p>setup_arch: enter</p>
<p>setup_arch: bootmem</p>
<p>arch: exit</p>
<p>-----------------------------------</p>
<p>What's the problems of these failure?</p>
<p>Does anybody here had succeeded booting the 2.6 kernel for SBS/K2 boards=
?</p>
<p>&nbsp;Thanks in advanced!<br>&nbsp;<br>&nbsp;&nbsp;&nbsp; Jianjie Ma<br>=
&nbsp;&nbsp;&nbsp;&nbsp;2005.6.27<br></p>

------=_Part_878_12092704.1119843666844--
