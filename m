Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <401D960B.2010502@iti.fi>
Date: Mon, 02 Feb 2004 02:12:59 +0200
From: Kate Alhola <kate@iti.fi>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: BSP integration
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am making bsp for my new MPC5200 board ( itipower5200 )
http://www.iti.fi/iti5200.php
I just like opinion that is it better that i make own version of
linuxppc_2_4_devel  tree to my site
or is there willignes to take this board as option to stantard
linuxppc_2_4_devel tree

There is few additions for standard tree
-RTL8201 PHY MDIO controll
-TSC2301 Audio codec, ADC and Touch screen controller
-MMC card interface using SPI
-Spartann 2E/Opencores-PCI based display controller

Of cource all drivers are GPL

Kate


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
