Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: Mon, 24 May 2004 13:27:45 +0200
From: Marc Leeman <marc.leeman@barco.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: memory dump
Message-ID: <20040524112745.GV23093@smtp.barco.com>
Reply-To: Marc Leeman <marc.leeman@barco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


A quick question:

Can I obtain the memory location of kernel variables based on the
System.map file in such a way that I can dump them with a BDI probe.

dump 0xabcdef 0x10000 dump.txt

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
