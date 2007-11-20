Return-Path: <clemens.koller@anagramm.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id 6FA60DDDDB
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 Nov 2007 22:08:51 +1100 (EST)
Message-ID: <4742C045.2070802@anagramm.de>
Date: Tue, 20 Nov 2007 12:08:53 +0100
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: abhi_linux <seema.pm@gmail.com>
Subject: Re: 2.6 kernel hangs after loading device tree
References: <fa84b3da0708290938l40d8f543oc0e34fa9bea806a4@mail.gmail.com>
	<13848328.post@talk.nabble.com>
In-Reply-To: <13848328.post@talk.nabble.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

 > charanya venkatraman wrote:
 >> Hi all
 >>        Sorry about the previous mail.Got sent  by mistake.
 >>
 >> Iam using the 2.6.22.5 kernel on MPC 8560 and MPC8540 on my custom
 >> board.Mykernel hangs after loading the device tree in both the
 >> processors. There is
 >> no output on the serial port after loading the device tree.

 >> I have tried the following console arguments:
 >> MPC8540: bootargs root=/dev/ram rw console=ttyS0,115200
 >> MPC8560:bootargs root=/dev/ram rw console=ttyCPM0,115200
 >>
 >> Any help on this issue??

Maybe your problem is related to... See the thread at:
http://ozlabs.org/pipermail/linuxppc-embedded/2007-November/028968.html
(I use Paulus' git tree.)

Regards,

Clemens Koller
__________________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Straße 45/1
Linhof Werksgelände
D-81379 München
Tel.089-741518-50
Fax 089-741518-19
http://www.anagramm-technology.com
