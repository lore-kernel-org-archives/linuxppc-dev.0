Return-Path: <markc@mail.com>
Received: from relay01.roc.ny.frontiernet.net (relay01.roc.ny.frontiernet.net
	[66.133.131.34]) by ozlabs.org (Postfix) with ESMTP id 866B767A64
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Jan 2005 02:19:55 +1100 (EST)
Message-ID: <003e01c4fd71$a7fec540$0301a8c0@chuck2>
From: "Mark Chambers" <markc@mail.com>
To: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>,
	<linuxppc-embedded@ozlabs.org>
References: <313680C9A886D511A06000204840E1CF0A6474FD@whq-msgusr-02.pit.comms.marconi.com>
Date: Tue, 18 Jan 2005 10:23:12 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: Linux 2.6-10.rc3 8xx: debugging (over-writing) content of bd_in
	fo structure in the kernel booting code
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>
> So what could go wrong here in terms of setting the baudrate for the
serial
> uart
> (which "presumably" causes printing 3 good characters and then garbage
> during kernel booting) ?
>

If you can get your hands on an oscilloscope and look at the TxD from your
board, you can get an exact measurement of your baudrate and make sure
you are on the right track. (Baudrate = 1/shortest-high-or-low-time)

Mark Chambers
