Return-Path: <vbordug@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 04BAE689C8
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 10 Jan 2006 20:32:14 +1100 (EST)
Message-ID: <43C37F1B.8000201@ru.mvista.com>
Date: Tue, 10 Jan 2006 12:32:11 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
MIME-Version: 1.0
To: Jonathan Qiang <jonathan@haliplex.com.au>
References: <32A7B31E4005134E8BA805EBAAFB9DCD9C7A1C@hellskitchen.haliplex.com.au>
In-Reply-To: <32A7B31E4005134E8BA805EBAAFB9DCD9C7A1C@hellskitchen.haliplex.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [Problem] linux 2.6.14 kernel hang up after the uImage
 uncompressed successfully
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Jonathan Qiang wrote:
> Hi,
> 
>  
> 
> I am doing booting linux kernel 2.6.14.5 from kernel.org on a kind of 
> *embedded ppc board, where the chip mpc8272 has been settled.*
> 
> *But  after u-boot(1.1.4) finished booting itself and uncompressed the 
> uImage(2.6.14.5 based). the kernel can not boot*
> 
This looks like odd or incomplete bootargs. Please search the list for relevant issues,
the likewise questions has been answered several times by me at least.

> *Successfully. It stop somewhere. the script is below: *
> 
> * *
> 
> * *
> 
> U-Boot 1.1.4 (Jan  3 2006 - 15:00:41)
> 
>  
> 
> MPC8272 Reset Status: Check Stop, External Soft, External Hard
> 
>  
> 
> MPC8272 Clock Configuration
> 
>  - Bus-to-Core Mult 5x, VCO Div 2, 60x Bus Freq  20-60 , Core Freq 100-300
> 
>  - dfbrg 1, corecnf 0x1b, busdf 7, cpmdf 1, plldf 0, pllmf 7
> 
>  - vco_out  528000000, scc_clk  132000000, brg_clk   33000000
> 
>  - cpu_clk  330000000, cpm_clk  264000000, bus_clk   66000000
> 
>  - pci_clk   22000000
> 
>  
> 
> CPU:   MPC8272 (HiP7 Rev 14, Mask 1.0 1K50M) at 330 MHz
> 
> I2C:   ready
> 
> DRAM:  SDRAM configuration:
> 
>         Refresh rate = 47, CAS latency = 3, Using Page Based Interleave
> 
>         Total size: 32 MB
> 
> FLASH Dectected: FLASH MFP, new id is 0x0089, Device ID is 0x8922
> 
> 32 MB
> 
> In:    serial
> 
> Out:   serial
> 
> Err:   serial
> 
> Ethos version: ac21 (DEVID:ac2, DEVVER:1, MFGVER: 1)
> 
> CFG_CMXFCR_VALUE=0x00370000, CFG_CMXFCR_MASK=0x007F0000
> 
> Net:   FCC2 ETHERNET
> 
> Hit any key to stop autoboot:  0
> 
> Using FCC2 ETHERNET device
> 
> ## Booting image at 00200000 ...
> 
>    Image Name:   Linux-2.6.14.5
> 
>    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
> 
>    Data Size:    750080 Bytes = 732.5 kB
> 
>    Load Address: 00000000
> 
>    Entry Point:  00000000
> 
>    Verifying Checksum ... OK
> 
>    Uncompressing Kernel Image ... OK
> 
>  
> 
> Then I have tried to use BDI2000 to debug the kernel, It seems that the 
> kernel can passed on console_init function. But still no message came 
> out even printk(KERN_NOTICE);  and printk(linux_banner);
> 
>  
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded


-- 
Sincerely, 
Vitaly
