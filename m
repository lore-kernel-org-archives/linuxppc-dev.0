Return-Path: <akonovalov@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 81ED0DDED6
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 24 Apr 2007 02:20:04 +1000 (EST)
Message-ID: <462CDDC4.7060701@ru.mvista.com>
Date: Mon, 23 Apr 2007 20:24:36 +0400
From: Andrei Konovalov <akonovalov@ru.mvista.com>
MIME-Version: 1.0
To: Mirek23 <miroslaw.dach@psi.ch>
Subject: Re: zImage.elf loads but does not start
References: <10079346.post@talk.nabble.com> <10142161.post@talk.nabble.com>
In-Reply-To: <10142161.post@talk.nabble.com>
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

Hi Mirek,

Mirek23 wrote:
> I have revised the xparameters_ml403.h and the setup of the FPGA part. I have
> found that the interrupt for the RS232 was not configured. Right now I was
> able to come to the point when the kernel was uncompressed but it did not
> start:
> 
> 
> loaded at:     00400000 004F9138
> 
> board data at: 004F7120 004F7138
> 
> relocated to:  00404064 0040407C
> 
> zimage at:     00404DF1 004F6BBB
> 
> avail ram:     004FA000 04000000
> 
> 
> 
> Linux/PPC load: console=ttl0,9600 ip=129.129.129.29 root=/dev/ram rw

If you use the UART Lite driver by Peter Korsgaard it sould be
"console=ttyUL0", not "console=ttl0".

Thanks,
Andrei

> Uncompressing Linux...done.
> 
> Now booting the kernel
> 
> 
> 
> 
> Does anybody has an idea what could be wrong?
> 
> Best Regards
> 
> Mirek
