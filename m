Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Reply-To: <joakim.tjernlund@lumentis.se>
From: "Joakim Tjernlund" <joakim.tjernlund@lumentis.se>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: gdb problems
Date: Thu, 10 May 2001 19:19:07 +0200
Message-ID: <IGEFJKJNHJDCBKALBJLLGEDNENAA.joakim.tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi

I am trying to debug ppclinux 2.4 and ppcboot on RPX CLLF board
connected to an Abatron emulator.

When I print variables in gdb I get an <error type> message
instead of the variable value. Breakpoints and stack trace etc. works
fine. I have enabled -g switch to gcc.

Any ideas?

 Jocke

I am using Montavistas CDK 1.2 on RH7.1

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
