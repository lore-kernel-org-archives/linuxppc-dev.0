Return-Path: <clemens.koller@anagramm.de>
Received: from moutvdomng.kundenserver.de (moutvdom.kundenserver.de
	[212.227.126.249]) by ozlabs.org (Postfix) with ESMTP id 5BB1A68292
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 15 Sep 2005 20:41:29 +1000 (EST)
Message-ID: <43294FD0.7050105@anagramm.de>
Date: Thu, 15 Sep 2005 12:41:20 +0200
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: FCG WANG Baohua <Baohua.WANG@alcatel-sbell.com.cn>
References: <A9DE2BAF233E444FA9C5E77A5825A01E86506C@ydmail.sbell.com.cn>
In-Reply-To: <A9DE2BAF233E444FA9C5E77A5825A01E86506C@ydmail.sbell.com.cn>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: A question about the /dev/ide
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello, Wang Baohua!

FCG WANG Baohua wrote:
> Dear all:
>   I had use the UPM of MPC8270 to create the device driver of my pcmcia CF card. 

Just an idea: There are IDE-to-CF adapters and PCI-IDE adapters with working drivers.
(for evaluation)

> How to create the "/dev/hda" device nodes? I had only "/dev/ide" device nodes,
> I want to use command like  "mkswap /dev/hda4".
> When I use "mkswap /dev/ide/host0/bus0/target0/lun0/part1p4",
> it shows the "No such file or directory" message. How can I create 
> the right device nodes? thanks!

man mknod?

But maybe you want to read some more things about devfs, udev, ... /etc/devfsd.conf
before you know what you are doing there?
Well... all that depends on your kernel/system config a bit...

Best greets,

-- 
Clemens Koller
_______________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Str. 45/1
81379 Muenchen
Germany

http://www.anagramm.de
Phone: +49-89-741518-50
Fax: +49-89-741518-19
