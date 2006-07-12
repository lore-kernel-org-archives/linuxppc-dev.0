Return-Path: <ales.gorkic@fs.uni-lj.si>
Received: from risc00.fs.uni-lj.si (risc00.fs.uni-lj.si [193.2.78.20])
	by ozlabs.org (Postfix) with ESMTP id B135567B95
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Jul 2006 23:38:27 +1000 (EST)
Received: from postar.fs.uni-lj.si (postar.fs.uni-lj.si [193.2.80.6])
	by risc00.fs.uni-lj.si (Postfix) with ESMTP id E4397EDADC
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Jul 2006 15:11:05 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Subject: re:Linux on Virtex4
Date: Wed, 12 Jul 2006 15:12:32 +0200
Message-ID: <6F0BA2FFAAB8204981CAE60F79FAD32A011B8E77@postar.fs.uni-lj.si>
From: =?iso-8859-2?B?QWxluSBHb3Jraeg=?= <ales.gorkic@fs.uni-lj.si>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Rick,

I saw on linuxppc-embedded at ozlabs.org that you are trying to port (or =
better you did) monta vista linux to Avnet's V4FX Mini-Module. I will =
try to deal with the same thing. My design is basically the same: all =
features of MM incorporated in CoreConnect style architecture. I also =
tried with Multi Port Memory Controller (MPMC2) and ported (memory =
works, but for LAN I still need phy datasheet) the Gigabit System =
Reference Design (GSRD2) to Mini-Module.
By using the MPMC2 memory core you can connect PPC directly to memory =
using two PLBs (data and instruction separated). This way you might =
solve the CPU cache errata. The problem with MPMC2 is that it consumes A =
LOT of BRAM and logic. I tried to build a full featured system, but =
V4FX12 lacks logic for the purpose.
Is there a way that you can help me with running MV linux on my system?

Cheers,


Ales Gorkic
