Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: greggiraud@netcourrier.com
To: linuxppc-embedded@lists.linuxppc.org
Subject: MPC8266ADS
Date: Wed, 26 Mar 2003 08:42:26 CET
Mime-Version: 1.0
Message-Id: <mnet1.1048664546.22205.greggiraud@netcourrier.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


HI,

I am using a MPC8266ADS card, and I want to put a PPCBOOT1.2.1 into it.

I am using BDI 2000, with code warrior to flash the card.

I work using the code "ppcboot1.2.1 for mpc8260ads". But I work with
MPC8266ADS-PCI. The difference between those two boards is that the
8266ads have a PCI (8260ads no), and that the MPC8260ADS have a sdram on
the local bus and the other not.

So I am searching for a solution to inhibe this sdram (local bus) that I
don't have.

=> The file board/mpc8260ads/mpc8260ads.c contain a function named
intdram. In that file, we init a local sdram and the sdram on the 60x
bus. We mustn't intilializase the local sdram.

Grégory Giraud

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
