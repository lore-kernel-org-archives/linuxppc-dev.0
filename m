Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <006301c40b57$26dc7960$ad1010ac@pc173>
Reply-To: =?Windows-1252?Q?Ga=EBl_Martin?= <g.martin@ateme.fr>
From: =?Windows-1252?Q?Ga=EBl_Martin?= <g.martin@ateme.fr>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: MPC5200 : dma and IDE
Date: Tue, 16 Mar 2004 14:04:01 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I am using linux on a MPC5200 Lite board. When I activate the DMA on IDE bus
and try to access to the disk, I have a kernel panic. I have seen in the
m5xxx.c that DMA is disabled until it will work.
Does anybody has a patch for this or should it be done ? If anyone already
has work on this problem, is it possible to share informations to fix it ?

Gael


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
