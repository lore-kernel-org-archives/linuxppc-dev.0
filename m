Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: 13 May 2003 16:05:15 +0800
Message-ID: <20030513160515.79677.qmail@eyou.com>
From: "rick.liu" <dovi@eyou.com>
To: linuxppc-embedded@lists.linuxppc.org
Reply-To: "rick.liu" <dovi@eyou.com>
Subject: Why my console output nothing
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all
      I am using ELDK to port linux to a simple MPC860T board. I use SMC1 to
connect to the serial port and as the console.But I can't go any further
because when i powerup,the console doesnot show any message.List my steps
here:
      1. edit ~/.kermrc as what was shown in <Denx ppcboot and linux
Guide(tqm8xxl)>.
      2. modify several line of  'TQM860L.h'.
      3. modify my UPM table and register OR1/BR1 to OR4/BR4(my sdram uses
cs4) in the file tqm8xx.c.
      4. bash>make distclean.
      5. bash>make TQM860L_config.
      7. bash>make all
      8. use a flash programmer to burn the u-boot.bin to my boot flash.
      9. bash>kermit -c
         Connecting to /dev/ttyS0, speed 115200
         Escape character:xxxxxxxxxxxxxxx :enabled
         Type xxxxxxxxxxxxxxxxxxxxxxxxxxx to got back
         or xxxxxxxxxxxxxxxxxxxxxxxxxxxxx options
         --------------------------------------
      10.power up,but nothing is output.

PS:my board info:MPC860T/SCC1 ETHERNET/SMC1 Serial/PCMCIA/CS0 FLASH 0/CS4
SDRAM

It's my first time to build a embedded linux project,wish u can help me out.

Thanks a lot!

Best regards!







--http://www.eyou.com
--稳定可靠的免费电子信箱  语音邮件  移动书签  日历服务  网络存储...亿邮未尽


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
