Return-Path: <vbordug@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (RT-soft-2.Moscow.itn.ru [80.240.96.70])
	by ozlabs.org (Postfix) with SMTP id DA70467EBA
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Aug 2005 17:25:35 +1000 (EST)
Message-ID: <42F9ABEB.7070304@ru.mvista.com>
Date: Wed, 10 Aug 2005 11:25:31 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
MIME-Version: 1.0
To: "Schaefer-Hutter, Peter" <Peter.Schaefer-Hutter@tfk-racoms.com>
References: <8E342283C2100540AAC5D10309705477749D97@rcexc.racoms.loc>
In-Reply-To: <8E342283C2100540AAC5D10309705477749D97@rcexc.racoms.loc>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: fs_enet on MPC885ADS
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi, Peter
Schaefer-Hutter, Peter wrote:
> Hi there,
> 
> Are there any boot options needed to enable the fs_enet driver
> on the MPC885ADS? I replaced CONFIG_DUET with CONFIG_MPC885ADS
> in drivers/net/fs_enet/mac-fec.c, but only got
> 
>   fs_enet.c:v0.1 (May 6, 2005)
>   NET: Registered protocol family 2
>   IP route cache hash table entries: 128 (order: -3, 512 bytes)
>   TCP established hash table entries: 512 (order: 0, 4096 bytes)
>   TCP bind hash table entries: 512 (order: -1, 2048 bytes)
>   TCP: Hash tables configured (established 512 bind 512)
>   TCP reno registered
>   TCP bic registered
>   NET: Registered protocol family 1
>   NET: Registered protocol family 17
>   IP-Config: Device `eth0' not found.
> 
Since this driver is platform-device based, you need to configure the PD 
structures. I'll try to submit a patch which will cover this...
> Reason i'm asking is that the current cpm_uart driver doesn't work
> with the SCC3 ethernet driver included in the MPC885 board support
> (as soon as ethernet is initialized, console output stops).
> 
This is very interesting since AFAIR SCC3 eth will not work with SMC2 on 
my board, but maybe something is changed. Anyway, oue fs_enet is pretty 
close to upstream so it would be nice if you will use (and test :)) it.
> Best regards,
> 
>  Peter
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 


-- 
Sincerely,
Vitaly
