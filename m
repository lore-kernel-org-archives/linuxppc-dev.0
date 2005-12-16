Return-Path: <vbordug@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 4CECC688C7
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 17 Dec 2005 07:09:08 +1100 (EST)
Message-ID: <43A31EE1.3030101@ru.mvista.com>
Date: Fri, 16 Dec 2005 23:09:05 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
MIME-Version: 1.0
To: Addison Baldwin <addison.baldwin@gmail.com>
References: <af313df20512161201u39280d30kdf1ace1c4569d50a@mail.gmail.com>
In-Reply-To: <af313df20512161201u39280d30kdf1ace1c4569d50a@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Unable to open an initial console
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Addison Baldwin wrote:
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
Only for 2.4, 2.6 is different for this.
console=ttyCPM0 should be there, and that device does have different major/minor comparing to ttyS0.
Note that the UART has to be enabled explicitly in kernel config, for more info, search this list archives.

>  We also checked our "/dev" and there was a link to console, pointing
> ttyS0. Also, ttyS0 was there too.
> 
> Does anyone have any idea how to fix it?
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 


-- 
Sincerely, 
Vitaly
