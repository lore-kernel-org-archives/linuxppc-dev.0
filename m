Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3418FDDE0F
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 27 Nov 2007 02:23:44 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1IwfoC-0003ll-C6
	for linuxppc-embedded@ozlabs.org; Mon, 26 Nov 2007 07:23:40 -0800
Message-ID: <13951808.post@talk.nabble.com>
Date: Mon, 26 Nov 2007 07:23:40 -0800 (PST)
From: khollan <khollan@daktronics.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Debugging with gdbserver slow
In-Reply-To: <13865715.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <13865715.post@talk.nabble.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



khollan wrote:
> 
> Hi everyone,
> 
> Im using gdbserver to debug Linux apps on my embedded board, but it takes
> like 3-6 sec to step one line of code.  Its about the same to go from
> breakpoint to breakpont.  Im using TCP to connect the host to the target. 
> Is this typical or is there some setting wrong or was it built wrong.  Its
> a PPC405 in a Xilinx FPGA.
> 
> Thanks
> 
> khollan
> 
How long does it take everyone else to step through code serial or TCP?
-- 
View this message in context: http://www.nabble.com/Debugging-with-gdbserver-slow-tf4846374.html#a13951808
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
