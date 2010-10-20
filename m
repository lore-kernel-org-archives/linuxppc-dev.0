Return-Path: <natalie@extricom.com>
Received: from smtp.extricom.com (smtp.extricom.com [192.114.46.18])
	by ozlabs.org (Postfix) with SMTP id 3935AB70CB
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Oct 2010 21:45:24 +1100 (EST)
Message-ID: <4CBEC62E.30900@extricom.com>
Date: Wed, 20 Oct 2010 12:36:30 +0200
From: Natalie Shapira <natalie@extricom.com>
MIME-Version: 1.0
To: galak@kernel.crashing.org, linuxppc-dev@ozlabs.org,
	leoli@freescale.com, zw@zh-kernel.org
Subject: Freescale P2020/ 85xx PCIe: DMA low throughtput
Content-Type: multipart/alternative;
	boundary="------------030008030101080305010702"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------030008030101080305010702
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I'm working on bring up for a new board based on Freescales p2020. I 
have a programmable FPGA as a PCIe device with a buffer I can write to 
and from.
I want to test  performence for the PCIe bus.
I encountered a problem while doing a DMA between the FPGA & DDR.
The whole buffer  moves  to and from  the device  with out mismatches 
but with low throughtput.
The thing is that the buffer divided to many transactions of byte size 
instead of transferring it in a burst.
I must mention that even a buffer of word size, divided in to byte 
transactions by the DMA (the core can read a word so it seems like the 
DMA fault.
I tried to change the latency timer, max latency, min latency and cache 
line in the configuration space of both sides of the pcie bus. It didn't 
help.
Do you have an idea what can it be?

Thanks,
Natalie.

--------------030008030101080305010702
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
</head>
<body bgcolor="#ffffff" text="#000000">
Hi, <br>
<br>
I'm working on bring up for a new board based on Freescales p2020. I
have a programmable FPGA
as a PCIe device with a buffer I can write to and from.<br>
I want
to test&nbsp; performence for the PCIe bus. <br>
I encountered a problem while doing a DMA between the FPGA &amp; DDR. <br>
The whole buffer&nbsp; moves&nbsp; to and from&nbsp; the device&nbsp; with out mismatches
but with low <font color="#000000">throughtput.</font> <br>
The thing is that the buffer divided to many transactions of byte size
instead of transferring it in a burst. <br>
I must mention that even a buffer of word size, divided in to byte
transactions by the DMA (the core can read a word so it seems like the
DMA fault.<br>
I tried to change the latency timer, max latency, min latency and cache
line in the configuration space of both sides of the pcie bus. It
didn't help.<br>
Do you have an idea what can it be? <br>
<br>
Thanks,<br>
Natalie.
</body>
</html>

--------------030008030101080305010702--
