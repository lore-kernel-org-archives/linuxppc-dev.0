Return-Path: <Alexander.Povolotsky@marconi.com>
Received: from mailgate.pit.comms.marconi.com (mailgate.pit.comms.marconi.com
	[169.144.68.6]) by ozlabs.org (Postfix) with ESMTP id E8C1467A66
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Jan 2005 02:24:48 +1100 (EST)
Message-ID: <313680C9A886D511A06000204840E1CF0A6474FE@whq-msgusr-02.pit.comms.marconi.com>
From: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>
To: "'Mark Chambers'" <markc@mail.com>
Date: Tue, 18 Jan 2005 10:24:01 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: Linux 2.6-10.rc3  8xx: debugging (over-writing)  content of b
	d_in fo structure  in the kernel booting code
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Sorry - no hardware instruments, support (and skills ;-) ) here ...
anything else to try software-wise (no JTAG debugging is available either) ?

-----Original Message-----
From: Mark Chambers [mailto:markc@mail.com]
Sent: Tuesday, January 18, 2005 10:23 AM
To: Povolotsky, Alexander; linuxppc-embedded@ozlabs.org
Subject: Re: Linux 2.6-10.rc3 8xx: debugging (over-writing) content of
bd_in fo structure in the kernel booting code


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
