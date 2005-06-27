Return-Path: <ma.jianjie@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.196])
	by ozlabs.org (Postfix) with ESMTP id 3DBBB67B74
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 27 Jun 2005 12:25:38 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id i11so272381wra
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 26 Jun 2005 19:25:36 -0700 (PDT)
Message-ID: <45d67d71050626192552d8e6b@mail.gmail.com>
Date: Mon, 27 Jun 2005 10:25:36 +0800
From: "signal@embedworld" <ma.jianjie@gmail.com>
To: linuxppc-embedded@ozlabs.org
In-Reply-To: <20050622020003.7882267B4C@ozlabs.org>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_794_2513388.1119839136918"
References: <20050622020003.7882267B4C@ozlabs.org>
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

------=_Part_794_2513388.1119839136918
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
=20
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

------=_Part_794_2513388.1119839136918
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div>Hi, </div>
<div>&nbsp;&nbsp;&nbsp; We had a SBS/K2 board,which had an IBM PowerPC 750 =
processor with cPCI interface. The old kernel on the boards worked quite we=
ll with Vxworks BSP and Linux 2.4.2 kernel. But it failed to boot with the =
new kernel version=20
2.6.8(I had tested other versions too). Here is the message I got from the =
HyperTerminal.</div>
<div>&nbsp;</div>
<div>-------------------------------------------------------------</div>
<div>Attaching to ATA disk device... done.<br>Loading /ata0/tftpboot/zImage=
.elf...1425876<br>Starting at 0x800000...</div>
<div><br>id mach(): done</div>
<div>
<p>MMU:enter</p>
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
<p>Does anybody here had succeeded&nbsp;booting the 2.6 kernel for SBS/K2 b=
oards?</p></div>
<div>&nbsp;Thanks in advanced!</div>
<div>&nbsp;</div>
<div>&nbsp;&nbsp;&nbsp; Jianjie Ma</div>
<div>&nbsp; 2005.6.27<br>&nbsp;</div>

------=_Part_794_2513388.1119839136918--
