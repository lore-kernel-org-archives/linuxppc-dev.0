Content-Type: text/plain
MIME-Version: 1.0
Message-ID: <S0989073849093.15304@webmail5.inner-21cn.com>
Date: Wed, 26 Sep 2001 15:09:06 +0800 (CST)
From: "yah" <hay8888@21cn.com>
To: linuxppc-embedded@lists.linuxppc.org
Cc: valette@crf.canon.fr
Subject: Invalid Boot-Record Signature
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,valette.

  I have a 16M flash disk on my target board(MCP750).I create a ppcboot partition on it,and dd a ppc zImage on it,(dd if=/usr/local/zImage of=/dev/hda).Then, I boot from it,but fail. what's wrong?

PPC1-Bug>ioi
I/O Inquiry Status:
CLUN  DLUN  CNTRL-TYPE  DADDR  DTYPE  RM  Inquiry-Data
   1     0  PC8477      0      $00    Y   <None>
  14     0  PBC-EIDEF1  0      $00    N   HYPERSTO NE FLASH DISK    1/09
  14    40  PBC-EIDEF1  4      $00    N   ST310211 A                3.05
  14    50  PBC-EIDEF1  5      $05    Y   TOSHIBA  CD-ROM XM-6502B  1013
PPC1-Bug>pboot 14 0 1
Booting from: PBC-EIDEF1, Controller 14, Drive 0
Device Name : /pci@80000000/pci1106,571@b,1/harddisk@0
Loading: Operating System

Invalid Boot-Record Signature
PPC1-Bug>



------------------------------------------------
想免受广告信的骚扰，请马上升级为21cn经济邮用户。
http://member.21cn.com/economy/upgrade.php
还有更便宜的吗？
http://adinfo.21cn.com/price/001.html
加入龙腾计划，与21cn齐飞。
http://www.21cn.com/21cnhtm/qy/index.html


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
