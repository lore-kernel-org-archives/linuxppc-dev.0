Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 813EEDDDFD
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 17 Aug 2008 02:38:39 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1KUOnQ-0005rM-9o
	for linuxppc-embedded@ozlabs.org; Sat, 16 Aug 2008 09:38:32 -0700
Message-ID: <19012924.post@talk.nabble.com>
Date: Sat, 16 Aug 2008 09:38:32 -0700 (PDT)
From: wangyanlong <killyouatonce@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: How to use ttyUL0 as input and use VGA as display?
In-Reply-To: <48A6CE85.2060207@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <931ae8260808160434g1ff6d856n46e5e420e487db57@mail.gmail.com>
	<48A6CE85.2060207@denx.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi,
   Thanks for all your replies :)
   if  i set console like this " console=tty0 console=ttyUL0,9600 
root=/dev/ram". The boot message display on both of  serial port and VGA.
But when the system come to the "sh", the VGA display no change at all ,and
all message comeout on serial port.The words i type only show on the serial
port , the VGA is no change:(
   regards:)
yanlong
-- 
View this message in context: http://www.nabble.com/How-to-use-ttyUL0-as-input-and-use-VGA-as-display--tp19010756p19012924.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
