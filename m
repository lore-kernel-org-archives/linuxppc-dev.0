Return-Path: <fboudra@gmail.com>
Received: from hs-out-0708.google.com (hs-out-0708.google.com [64.233.178.249])
	by ozlabs.org (Postfix) with ESMTP id 0805CDDFE9
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 21 Apr 2008 18:45:05 +1000 (EST)
Received: by hs-out-0708.google.com with SMTP id z77so1021514hsz.9
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 21 Apr 2008 01:45:04 -0700 (PDT)
Message-ID: <6a2e33620804210145n79470da4v549ab0c19c35775@mail.gmail.com>
Date: Mon, 21 Apr 2008 10:45:02 +0200
From: "Fathi Boudra" <fboudra@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: stuck on update mpc834x based board from 2.6.20 to 2.6.21
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_11624_4566137.1208767502893"
Reply-To: fboudra@gmail.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_11624_4566137.1208767502893
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I've got a mpc8347e based board with a working 2.6.20 kernel and a dtb.
I wasn't able to boot on a more recent kernel (>2.6.20).

To update my config. I tried ppc and powerpc arch.:

a) make ARCH=ppc CROSS_COMPILE=ppc_6xx- oldconfig
then select 6xx/MPC834X SYS

b) make ARCH=powerpc CROSS_COMPILE=ppc_6xx- oldconfig
then select 83XX/MPC834X MDS

On each generated kernel, I'm stuck at:
Booting using flat device tree at 0x3c0000

For infos, I use ELDK 4.2, U-Boot 1.1.4 and always the same dtb.

did I miss something ?

cheers,

Fathi

------=_Part_11624_4566137.1208767502893
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,<br><br>I&#39;ve got a mpc8347e based board with a working 2.6.20 kernel and a dtb.<br>I wasn&#39;t able to boot on a more recent kernel (&gt;2.6.20).<br><br>To update my config. I tried ppc and powerpc arch.:<br><br>a) make ARCH=ppc CROSS_COMPILE=ppc_6xx- oldconfig<br>
then select 6xx/MPC834X SYS<br><br>b) make ARCH=powerpc CROSS_COMPILE=ppc_6xx- oldconfig<br>then select 83XX/MPC834X MDS<br><br>On each generated kernel, I&#39;m stuck at:<br>Booting using flat device tree at 0x3c0000<br>
<br>For infos, I use ELDK 4.2, U-Boot 1.1.4 and always the same dtb.<br><br>did I miss something ?<br><br>cheers,<br><br>Fathi<br><br>

------=_Part_11624_4566137.1208767502893--
