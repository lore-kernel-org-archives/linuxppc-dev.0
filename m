Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: "Stephan Linke" <Stephan.Linke@epygi.de>
To: "Linuxppc-Embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: running 8xx without UART
Date: Thu, 12 Jun 2003 09:34:08 +0200
Message-ID: <FCEAKDJJAPHPLJFINDAJAEHGDCAA.Stephan.Linke@epygi.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

is it possible to make a 8xx kernel without setting up one of the serial interfaces for UART mode? It seames to me like it is only
possible to choose between the CPM interfaces.
We are experiencing problems with SCC3 running ethernet and SMC1 as console interface on a 852.

Thanx, Stephan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
