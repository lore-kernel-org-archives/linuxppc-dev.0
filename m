Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.242])
	by ozlabs.org (Postfix) with ESMTP id 04E5CDDE0F
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Feb 2008 06:36:22 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so1391243anc.78
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 12 Feb 2008 11:36:21 -0800 (PST)
Message-ID: <fa686aa40802121136k57a2ea20n446cfe6183ca7909@mail.gmail.com>
Date: Tue, 12 Feb 2008 12:36:21 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Ricardo Ayres Severo" <severo.ricardo@gmail.com>
Subject: Re: Howto get __log_buf on a Xilinx FPGA
In-Reply-To: <5ee408090802121130m2a641637s4b75a8a144ec2efc@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <5ee408090802121130m2a641637s4b75a8a144ec2efc@mail.gmail.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Feb 12, 2008 12:30 PM, Ricardo Ayres Severo <severo.ricardo@gmail.com> wrote:
>
> Linux/PPC load: console=ttyS0,9600
>
> Uncompressing Linux...done.
>
> Now booting the kernel
> ---output end---
>
> after a while I stop the debugger and type rst in xmd.
> then I ask gdb to dump the memory from position 0x1f3d5c to 0x1f3fff
> and only trash is returned.
>
> What am I doing wrong? Or the kernel really isn't being executed?

In this case it seems like the kernel isn't even booting.  You can try
inserting progress markers into the kernel boot path to spit single
characters out of the uartlite port.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
