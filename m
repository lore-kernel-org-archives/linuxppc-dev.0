Return-Path: <kodiakuppercut@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.180])
	by ozlabs.org (Postfix) with ESMTP id 6C400DDF38
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jan 2009 02:18:06 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id l24so970610waf.9
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Jan 2009 07:18:03 -0800 (PST)
MIME-Version: 1.0
Date: Wed, 21 Jan 2009 08:18:03 -0700
Message-ID: <bc81dc640901210718l18edbc6ehffbb6709c0daac3f@mail.gmail.com>
Subject: Non-contiguous physical memory
From: Aaron Pace <kodiakuppercut@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

I'm working on a design using a Freescale MPC8572 processor.
We are using 4 gigs of memory, and also need a window of 512 megs for
PCI-E devices.
What I have done is set up the first 2G of memory from 0x0 - 0x7f, the
PCI windows from 0x8 - 0x9f, localbus devices + CCSRBAR from 0xf -
0xffffffff, and the second 2G of ram from 0x1.0000.0000 -
0x1.8000.0000.
I've got this set up in U-boot (although it only uses the low mem),
but Linux will only use the first contiguous physical area (the
message is "Only using first contiguous memory region").
Is it possible to have multiple non-contiguous physical memory chunks
used for memory allocation?
If not, is there a better way to set this up without losing large
chunks of memory?

Thanks,
Aaron
