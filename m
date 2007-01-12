Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.173])
	by ozlabs.org (Postfix) with ESMTP id 92178DDE29
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 16:59:12 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so641406ugf
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jan 2007 21:59:11 -0800 (PST)
Message-ID: <528646bc0701112159m670f3a51r3061838080905dcc@mail.gmail.com>
Date: Thu, 11 Jan 2007 22:59:10 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: Fw: [Bugme-new] [Bug 7808] New: Xilinx ML403 does not boot
In-Reply-To: <528646bc0701110634v5eccd80aue030fcd25807a644@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <20070111010358.851692fb.akpm@osdl.org>
	<528646bc0701110634v5eccd80aue030fcd25807a644@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, BSowislo@gmx.de,
	"bugme-daemon@kernel-bugs.osdl.org" <bugme-daemon@bugzilla.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/11/07, Grant Likely <grant.likely@secretlab.ca> wrote:
> okay, I will investigate today

Hmmm...

Using the top of Linus' tree, I cannot reproduce this problem.  Could
this be something exposed by the compiler version?

Cross compiler: ELDK 4.0 on and amd64 Linux host.
Target: Xilinx EDK 8.1 reference design bitstream.

Console output:

loaded at:     00400000 004DC13C
board data at: 004DA124 004DA13C
relocated to:  0040408C 004040A4
zimage at:     00404E19 004D93A0
avail ram:     004DD000 04000000

Linux/PPC load: console=ttyS0,9600
Uncompressing Linux...done.
Now booting the kernel
[    0.000000] Linux version 2.6.20-rc4-g0404f87f
(grant@weasley-twins) (gcc version 4.0.0 (DENX ELDK 4.0 4.0.0)) #317
Thu Jan 11 14:28:05 MST 2007
[    0.000000] Xilinx ML403 Reference System (Virtex-4 FX)
[    0.000000] Zone PFN ranges:
...
