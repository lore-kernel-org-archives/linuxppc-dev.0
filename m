Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <75DF04AC5ED4D511A9810090273CB4163A66F0@ROKONET-E>
From: Eli Brin <elib@rokonet.co.il>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: 8xx SCC and SMC uart latency
Date: Mon, 13 Jan 2003 11:37:28 +0200
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

We are using the FADS board and MPC860T CPU, with ELDK 2.0.2 (kernel
06-10-2002).

We have a device that communicates over RS232 at 9600 bps.  This device has
a 4 mSec timeout, i.e we have to reply in less then 4mSec.

The packets are usually small (4-6 Bytes).  We communicate successfully with
the device, but only if we change the timeout to above 10mSec.

It seems that it takes 5-8 mSec for us to reply.  This is the same if we use
SMC or SCC.  We tried to play with the MAX_IDL and the Tx/Rx buffer sized,
but with no success.

Has anyone an idea on how to minimize the uart latency?

If we use the same code on a PC (i386) we reply in 300 microSec.

Thank you, and a happy New Year
Eli Brin

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
