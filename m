Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <B164B53F5BD6D511888D009027732E1A02497B@ntserver.act.domain>
From: Rudolf Ladyzhenskii <rudolf.ladyzhenskii@act-aus.net>
To: "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: Using BDI2000 for module debugging
Date: Fri, 23 Nov 2001 16:13:02 +1100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi, all

I have a particular module that crashes the system during installation.
What is the best way to use BDI2000 to stop on the first instruction of the
init_module()?

I can do kernel debugging with BDI2000, but I am not sure how to get to the
dynamically loaded modules.

Thanks,

/************************/
Rudolf Ladyzhenskii
DSP Engineer
Advanced Communication Technologies
ph.  +61 3 8080 8215
fax. +61 3 9672 8800
Level 9, 190 Queen Street,
Melbourne, 3000
Australia
/***********************/


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
