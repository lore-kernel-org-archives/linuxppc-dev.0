Return-Path: <severo.ricardo@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.183])
	by ozlabs.org (Postfix) with ESMTP id 9D3C6DDFB0
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Feb 2008 06:43:35 +1100 (EST)
Received: by py-out-1112.google.com with SMTP id z59so5307367pyg.27
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 12 Feb 2008 11:43:34 -0800 (PST)
Message-ID: <5ee408090802121143i719a6bebledc11395d9bd4ac1@mail.gmail.com>
Date: Tue, 12 Feb 2008 17:43:33 -0200
From: "Ricardo Ayres Severo" <severo.ricardo@gmail.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: Howto get __log_buf on a Xilinx FPGA
In-Reply-To: <fa686aa40802121136k57a2ea20n446cfe6183ca7909@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <5ee408090802121130m2a641637s4b75a8a144ec2efc@mail.gmail.com>
	<fa686aa40802121136k57a2ea20n446cfe6183ca7909@mail.gmail.com>
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

Grant,

thanks, I'll do this.

On Feb 12, 2008 5:36 PM, Grant Likely <grant.likely@secretlab.ca> wrote:
> On Feb 12, 2008 12:30 PM, Ricardo Ayres Severo <severo.ricardo@gmail.com> wrote:
> >
> > Linux/PPC load: console=ttyS0,9600
> >
> > Uncompressing Linux...done.
> >
> > Now booting the kernel
> > ---output end---
> >
> > after a while I stop the debugger and type rst in xmd.
> > then I ask gdb to dump the memory from position 0x1f3d5c to 0x1f3fff
> > and only trash is returned.
> >
> > What am I doing wrong? Or the kernel really isn't being executed?
>
> In this case it seems like the kernel isn't even booting.  You can try
> inserting progress markers into the kernel boot path to spit single
> characters out of the uartlite port.
>
> g.
>
> --
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
>



-- 
Ricardo Ayres Severo <severo.ricardo@gmail.com>
