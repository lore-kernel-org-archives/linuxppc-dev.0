Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <607BF0A2B4F3D411A09500508BC225427E8328@mailctx.datum.com>
From: Geoff Wyche <GWyche@DATUM.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: MPC8xx + serial console on SCC
Date: Fri, 19 Oct 2001 08:39:47 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Is anyone here working on an 8xx based board and using an SCC for serial
console?

I've been working on some patches for it, and would like to compare notes.

The board I'm working with is a custom board that uses an 860T.  The
particular difficulties I'm having are very much related to serial console
IO on an SCC.  After following linuxppc-embedded for a while, it seems use
of SCCs for serial is in the minority of configurations out there.

Comments?

--Geoff
gwyche@datum.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
