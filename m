Return-Path: <dargaud@lpsc.in2p3.fr>
Received: from lpsc-mail.in2p3.fr (lpsc-mail.in2p3.fr [134.158.40.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 18B79DDE05
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Apr 2008 19:22:50 +1000 (EST)
Received: from LPSC0173W (lpsc0173w.in2p3.fr [134.158.40.173])
	by lpsc-mail.in2p3.fr (8.13.1/8.13.1/In2p3) with SMTP id m389Mjxu016013
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Apr 2008 11:22:45 +0200
Message-ID: <10d401c8995a$1a63beb0$f52f9e86@LPSC0173W>
From: "Guillaume Dargaud" <dargaud@lpsc.in2p3.fr>
To: <linuxppc-dev@ozlabs.org>
References: <10a101c898c4$c183ee40$f52f9e86@LPSC0173W>
	<fa686aa40804072055i1f7036afn4d453e968cc625d6@mail.gmail.com>
Subject: Re: Booting a Xilinx board
Date: Tue, 8 Apr 2008 11:22:39 +0200
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Are you using uartlite?  Try console=ttyUL0.

Thanks, I didn't know that.

> But Stephen is right, the first thing you should do is look at
> __log_buf.  You can find its address in the System.map file.

Unfortunately, the installation of the cable driver failed for some reason. 
I'll have to work on it...
-- 
Guillaume Dargaud
http://www.gdargaud.net/Antarctica/
