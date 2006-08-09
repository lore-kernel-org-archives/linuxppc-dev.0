Return-Path: <avolkov@varma-el.com>
Received: from amanaus.varma-el.com (amanaus.varma-el.com [195.144.240.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.varma-el.com",
	Issuer "mail.varma-el.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 8B864679E7
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 10 Aug 2006 09:34:29 +1000 (EST)
Message-ID: <44DA6A72.7020502@varma-el.com>
Date: Thu, 10 Aug 2006 03:06:26 +0400
From: Andrey Volkov <avolkov@varma-el.com>
MIME-Version: 1.0
To: urwithsudheer <urwithsudheer@gmail.com>
Subject: Re: regarding pci  vga card output with powerpc
References: <44D7097C.7040907@gmail.com>
In-Reply-To: <44D7097C.7040907@gmail.com>
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

urwithsudheer wrote:
> Hello All,
> I am working with a pci based vga card. I have connected the vga card 
> next to the  pci slot of my target processor on the baseboard.
> I have connected a monitor to the vga card.
> When i boot linux from minicom, i could see all the kernel log messages 
> on both the minicom and vga card monitor. But on the vga monitor, i 
> could not see any messages after asking for login as below:
> .
> .
> 
> Mounting filesystems
> Running depmod
> Setting up networking on loopback device:
> Setting up networking on eth0:
> eth0: PHY is Marvell 88E11x1 (1410cc2)
> Adding static route for default gateway to 192.168.3.1:
> Setting nameserver to 192.168.0.1 in /etc/resolv.conf:
> Starting inetd:
> 
> login:
> 
> 
> Though i am entering my login and passwd at the minicom, nothing comes 
> on to the vga monitor. But i am able to write to vga monitor using the 
> following commands from minicom:
> 
> # echo "Hello" > /dev/tty1
> # echo "Hi " > /dev/tty1
> My requirement is to get on the vga monitor whatever i am typing on the 
> minicom after logging into the linux like .
> ls or pwd commands.
> 
> Anyone pl help me.
> 
> Thanks & Regards
> Sudheer
> 

See Documentation/kernel-parameters.txt.

If be short, add:

     console=/dev/ttySxx console=/dev/tty1

(both) to a kernel parameters string.

--
Regards
Andrey
