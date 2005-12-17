Return-Path: <ncunningham@cyclades.com>
Received: from cunningham.myip.net.au (cust8446.nsw01.dataco.com.au
	[203.171.93.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A6E596889F
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 17 Dec 2005 16:33:42 +1100 (EST)
From: Nigel Cunningham <ncunningham@cyclades.com>
To: Addison Baldwin <addison.baldwin@gmail.com>
In-Reply-To: <af313df20512161201u39280d30kdf1ace1c4569d50a@mail.gmail.com>
References: <af313df20512161201u39280d30kdf1ace1c4569d50a@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1134796988.21103.1636.camel@localhost>
Mime-Version: 1.0
Date: Sat, 17 Dec 2005 15:23:08 +1000
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Unable to open an initial console
Reply-To: ncunningham@cyclades.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi.

On Sat, 2005-12-17 at 06:01, Addison Baldwin wrote:
> I was sucessful to port U-Boot to our 8272 board. Now I'm experiencing
> a problem:
> 
> Our Kernel hangs with the message that says it was trasnferring
> control to linux. A post morten analyzes indicated that it stopped at
> "Unable to open an initial console" in the memory sapce where console
> output should be out (in the sdram, like I had found somewhere in this
> list, how to do it).
> 
> I have checked the bootargs values, it is ok:
> bootargs root=/dev/ram console=ttyS0,115200
> 
>  We also checked our "/dev" and there was a link to console, pointing
> ttyS0. Also, ttyS0 was there too.

Are you using an initrd or initramfs? If so, the device node needs to
exist on that filesystem. This message will only occur if the kernel is
unable to open /dev/console for rw access.

Hope this helps.

Nigel
