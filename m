Return-Path: <fabien.fb@gmail.com>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.189])
	by ozlabs.org (Postfix) with ESMTP id 9ECA4DDDFA
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 14 Sep 2007 00:05:13 +1000 (EST)
Received: by fk-out-0910.google.com with SMTP id z22so589596fkz
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Sep 2007 07:05:12 -0700 (PDT)
Message-ID: <f8f856500709130705t2109e559v19f0ffac318a4756@mail.gmail.com>
Date: Thu, 13 Sep 2007 16:05:11 +0200
From: "fabien boucher" <fabien.fb@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Informations about mem and proc environment between bootloader and
	kernel
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_20268_9656084.1189692311721"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_20268_9656084.1189692311721
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

And I need some help for my project (I'm in internship) to port linux on a
custom board.
This board has been developped by the company where i'm doing the intership
and it's
based on a MPC875 with RAM and Flash chips and several other devices.
Currently the board run with a BSP developped
by the company's developpers, the BSP launch Psos.
This BSP is able to decompress an image and load it in RAM.
I plan to use U-boot to be more able to boot a kernel but as it's not a
common
board so it's not initialy supported by U-boot. So I have two choices first
use the BSP with some changes to adapt it for loading the Linux kernel or
using U-boot.
I'm looking for informations about the memory and processor environment
needed by linux to
boot properly for evaluate whether the use of a customize BSP is the easiest
way against
the port of a new board under U-boot. So if someone know where i can found
those informations
concerning the step between where the boot program have control of the cpu
and where Linux
take control.

Thank you,
Fabien

------=_Part_20268_9656084.1189692311721
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

And I need some help for my project (I&#39;m in internship) to port linux on a custom board.<br>This board has been developped by the company where i&#39;m doing the intership and it&#39;s<br>based on a MPC875 with RAM and Flash chips and several other devices.
<br>Currently the board run with a BSP developped<br>by the company&#39;s developpers, the BSP launch Psos.<br>This BSP is able to decompress an image and load it in RAM.<br>I plan to use U-boot to be more able to boot a kernel but as it&#39;s not a common
<br>board so it&#39;s not initialy supported by U-boot. So I have two choices first<br>use the BSP with some changes to adapt it for loading the Linux kernel or using U-boot.<br>I&#39;m looking for informations about the memory and processor environment needed by linux to
<br>boot properly for evaluate whether the use of a customize BSP is the easiest way against<br>the port of a new board under U-boot. So if someone know where i can found those informations<br>concerning the step between where the boot program have control of the cpu and where Linux
<br>take control.<br><br>Thank you,<br>Fabien<br><br>

------=_Part_20268_9656084.1189692311721--
