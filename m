Return-Path: <jwboyer@gmail.com>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.28])
	by ozlabs.org (Postfix) with ESMTP id 9C43DDE090
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Apr 2009 03:22:39 +1000 (EST)
Received: by yx-out-2324.google.com with SMTP id 31so107048yxl.39
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Apr 2009 10:22:38 -0700 (PDT)
MIME-Version: 1.0
Sender: jwboyer@gmail.com
In-Reply-To: <20090417154628.43F859D0055@mail178-wa4.bigfish.com>
References: <20090414203313.8D8F11BE8056@mail209-sin.bigfish.com>
	<AC5E1C3367E37D44970B81A6ADD1DA2C0729E57E@SDCEXCHANGE01.ad.amcc.com>
	<20090417154628.43F859D0055@mail178-wa4.bigfish.com>
Date: Fri, 17 Apr 2009 13:22:37 -0400
Message-ID: <625fc13d0904171022u4d7d5d8cve0ccfb74cc31f554@mail.gmail.com>
Subject: Re: Question about DBCR0 initialization for 440
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: John Linn <John.Linn@xilinx.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, hollisb@us.ibm.com,
	Tirumala Reddy Marri <tmarri@amcc.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 17, 2009 at 11:46 AM, John Linn <John.Linn@xilinx.com> wrote:
> Josh, any thoughts on putting this into head_44x.S?

The code in the fsl file looks like the right solution.  I do have an
odd question though, in that it's hard for the
kernel to really know if something like a BDI is running.  Namely,
that config option doesn't cover RiscWatch in an obvious manner.

I also wonder if it's possible to have a host system be setting those
registers in a guest KVM system so the guest could be debugged with
gdb...  Hollis, any idea on that?

josh
