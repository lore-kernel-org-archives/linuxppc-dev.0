Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: 12 Jun 2002 10:00:16 -0000
Message-ID: <20020612100016.15037.qmail@webmail25.rediffmail.com>
MIME-Version: 1.0
From: "somshekar chandrashekar kadam" <ppclinux@rediffmail.com>
Reply-To: "somshekar chandrashekar kadam" <ppclinux@rediffmail.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: ramdisk image start not initialisied
Content-type: text/plain;
	format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hi,
    i am using monta vista cdk 2.0 code porting it to my board
   I am compiling zImage.initrd for my mpc8260,
  its saying "Couldnt't find valid ramdisk image  "

  i am trying to trace where rd_ramdisk_start is initialised i am
not getting it,

  actually in ramdisk_startup routine rd_ramdisk_start is set but
this routine is not called

i think i am not attaching proper ramdisk image
any idea where can i get ramdisk image for 8260 or
what should i do


  please help me ,any idea where i am going worng ,or i need to
set
  thanks for advice in advance
regards
somshekar


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
