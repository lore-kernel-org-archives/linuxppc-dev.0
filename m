Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: "Prabhakar Kalasani" <kalasani@sena.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: PCMCIA modem card is not responding
Date: Mon, 9 Feb 2004 14:16:16 +0900
Message-ID: <NCEHKHHDAHEBBGFMCFHCEEHPCAAA.kalasani@sena.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,
I'm working with MPC855T Processor based target board, I'm trying to support
3CXM556 Megahertz Cellular Modem PC Card , I could able to detetect the card
like...

root@192.168.6.6:/# cardctl ident

Socket 0:
  product info: "3Com", "3CXM/3CCM556", "Megahertz 56K Cell/Telephony Modem"
  manfid: 0x0101, 0x0034
  function: 2 (serial)

root@192.168.6.6:/# cardctl config

Socket 0:
  Vcc 5.0V  Vpp1 0.0V  Vpp2 0.0V
  interface type is "memory and I/O"
  irq 9 [exclusive] [level]
  speaker output is enabled
  function 0:
    config base 0x0300
      option 0x60 status 0x08
    io 0x03f8-0x03ff [8bit]

But I couldn't communicate with the card, If i send Modem string from
Minicom I'm not getting any responce from the target , Do i need to change
anything related to MPC855T .

Please help me out.

Thanks and Regards,
Prabhakar Kalasnai

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
