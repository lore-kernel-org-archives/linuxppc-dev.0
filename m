Return-Path: <vbordug@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id B2713684E9
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  8 Oct 2005 01:47:31 +1000 (EST)
Message-ID: <43469891.9080908@ru.mvista.com>
Date: Fri, 07 Oct 2005 19:47:29 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
MIME-Version: 1.0
To: Alex Zeffertt <ajz@cambridgebroadband.com>
References: <20051007163735.31f48aeb.ajz@cambridgebroadband.com>
In-Reply-To: <20051007163735.31f48aeb.ajz@cambridgebroadband.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: Oops accessing BCSR on 8272ADS
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
> I've just downloaded linux-2.4.31 from kernel.org and compiled it for
> the mpc8272ads board.
> 
> When I boot the kernel it oopses in fcc_enet.c:init_fcc_startup() at
> the point where it tries to write to the BCSR.
> 
> Does anybody know why writing to the BCSR should cause a machine
> check?
> 
I guess I was not ioremapped/io_block_mapped properly.
Take a look into arch/ppc/kernel/m8260_setup.c m8260_map_io() function.
Anyway BCSR is better to be ioremapped in the place it is required.
> TIA,
> 
> Alex
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 


-- 
Sincerely,
Vitaly
