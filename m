Return-Path: <owner-linuxppc-dev@lists.linuxppc.org>
Message-ID: <A3E34B558F5CD211B4980008C7A4A99002424172@sparrow.gso.mcs.marconi.com>
From: "Banks, Kelly" <kelly.banks@gilbarco.com>
To: "'linuxppc-dev@lists.linuxppc.org'" <linuxppc-dev@lists.linuxppc.org>
Subject: Extended Scheduling Latency on LinuxPPC 2.4.10
Date: Tue, 26 Feb 2002 16:21:27 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Running LinuxPPC 2.4.10 in an MPC860 board, I am experiencing an extended
period of time when the kernel seems to be 'out to lunch'.

The system receives a periodic poll request over SCC2 & is designed to
respond to the poll in a timely fashion.

Occasionally, the system appears to 'hang' for a period of time from between
2 & 8 Seconds.  During this delay, poll requests seem to be queued into
SCC2's input buffer because, eventually, the system comes back to life &
responds to each poll request received.

I am searching through system & driver interrupt routines looking for a
potential extended processing loop but so far, it has been to no avail.

The 2.4.10 low-latency patch has been ported into the system (successfully,
I think), but the problem still exists.

Any guidance which you may be able to provide would be greatly appreciated.

Kelly

This document contains confidential information of Gilbarco Inc.
In consideration of receipt of this document, the recipient agrees
not to reproduce, copy, use or transmit this document and/or the
information contained herein, in whole or in part, or to suffer
such actions by others, for any purpose, except with written
permission, first obtained, of Gilbarco Inc. and further agrees
to surrender same to Gilbarco Inc. upon demand.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
