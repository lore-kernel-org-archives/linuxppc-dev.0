Return-Path: <jonmasters@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.199])
	by ozlabs.org (Postfix) with ESMTP id 1BC462BDA0
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 26 Oct 2004 07:13:48 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id 43so92105wri
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 25 Oct 2004 14:13:47 -0700 (PDT)
Message-ID: <35fb2e59041025140776cfe174@mail.gmail.com>
Date: Mon, 25 Oct 2004 22:07:07 +0100
From: Jon Masters <jonmasters@gmail.com>
To: Peter Ryser <peter.ryser@xilinx.com>
In-Reply-To: <417D2B5E.8050200@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <1098701468l.31592l.0l@ipnnarval> <417D2B5E.8050200@xilinx.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: uboot and ppc405
Reply-To: jonathan@jonmasters.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, 25 Oct 2004 09:35:42 -0700, Peter Ryser <peter.ryser@xilinx.com> wrote:

> please have a look at "Getting started with U-Boot and ML300"
> http://www.xilinx.com/bvdocs/appnotes/xapp542.pdf that describes how to
> use U-Boot with Xilinx Virtex-II Pro devices.

This appnote assumes that he's using the ML300, has the Montavista
tree, and a few other general assumptions that might well not be true
here, but is otherwise interesting if they decide to heed our
suggestions of using the SystemACE in the design.

btw Peter, I've been moaning about the weird interrupt behaviour of
the SysACE on e.g. the Memec board for some time (see archives for
various other people's experiences too) - and I've spoken to several
folks at Xilinx without getting very far. If there's a fundamental
problem then it probably makes sense for us to help get it fixed.

Cheers,

Jon.
