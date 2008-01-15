Return-Path: <raul.moreno@telvent.abengoa.com>
Received: from envio.abengoa.com (envio.abengoa.com [217.15.37.68])
	by ozlabs.org (Postfix) with ESMTP id D2F51DDE3F
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Jan 2008 01:58:57 +1100 (EST)
Subject: problem with CF 
To: linuxppc-embedded@ozlabs.org
Message-ID: <OFEB5D25DA.C7D8C3B7-ONC12573D1.004E9B75-C12573D1.00517883@abengoa.com>
Date: Tue, 15 Jan 2008 15:49:28 +0100
From: raul.moreno@telvent.abengoa.com
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



Hi,

I am trying to use a compact Flash (CF) throu PCMCIA. So I selected the=

CONFIG_BLK_DEV_IDECS and CONFIG_PCMCIA_M8XX kernel options, but not the=

CONFIG_BLK_DEV_MPC8xx_IDE one.
The  problem occurs when I insert the CF, because the ide_config fails:=

      ide-cs: ide_register() 0x  0 & 0x  e, irq 7 failed

I think the issue is in the idecs_register function that always returns=
 -1.
I guess the problem is the two first parameter of this function (io_bas=
e
and ctl_base are 0x0 and 0xe respectively), but I don't know if it must=
 be
so or what values they must have.

I am using a MPC866 with a linux kernel 2.6.22.

I would thank some help.

Ra=FAl Moreno=
