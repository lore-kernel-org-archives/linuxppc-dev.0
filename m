Return-Path: <vbordug@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 58290683CF
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  7 Oct 2005 21:57:46 +1000 (EST)
Message-ID: <434662B8.5000407@ru.mvista.com>
Date: Fri, 07 Oct 2005 15:57:44 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
MIME-Version: 1.0
To: Alex Zeffertt <ajz@cambridgebroadband.com>
References: <20051006173628.53f25862.ajz@cambridgebroadband.com>
In-Reply-To: <20051006173628.53f25862.ajz@cambridgebroadband.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: mpc8272ads support in linux-2.4
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Alex Zeffertt wrote:
> Hi list,
> 
> I have read that the MPC8272ADS board is supported in linux-2.6.  Has
> anybody backported this support to linux-2.4.  I am using linux-2.4.25
> from ELDK.  If anyone has a patch I would be very grateful if they
> sent it to me.
> 
Yes, it has been supported within 2.4 tree in bitkeeper days.
The source you can rsync from source.mvista.com (take a look at 
http://penguinppc.org/kernel/.
> Regards,
> 
> Alex Zeffertt
> 
> PS Does anyone know where the master PPC patches are kept?  I.e. the
> ones you apply to kernels from kernel.org to get all the stuff that
> hasn't yet been upstreamed.
Actually answer is nowhere AFAIK. Now with git, we are working with 
maintainers, and often with Andrew Morton directly, so ppc patches 
usually are pushed without inbetween place unlike they used to.
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 


-- 
Sincerely,
Vitaly
