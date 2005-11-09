Return-Path: <vbordug@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 8FCF2686D6
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 10 Nov 2005 00:21:25 +1100 (EST)
Message-ID: <4371F7D3.7070303@ru.mvista.com>
Date: Wed, 09 Nov 2005 16:21:23 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
MIME-Version: 1.0
To: srideep.devireddy@wipro.com
References: <6AD9F6A5F6E096408F0B703773355A075BB210@CHN-SNR-MBX01.wipro.com>
In-Reply-To: <6AD9F6A5F6E096408F0B703773355A075BB210@CHN-SNR-MBX01.wipro.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: u-boot + kernel (help required)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

srideep.devireddy@wipro.com wrote:
>  
> 
> Hi ,
> 
>    
> 
> we were able to get the u-boot up on MPC8272ADS board . We are just 
> struck up in bringing up the Linux... we get the following errors .. 
> actually we made a uImage  from vmlinux and tried to tftp and used bootm 
> 100000 , we eneded up with these errors ...actually after the message 
> Uncompressing Kernel Image ... OK board gets reset .Any help would be 
> thankfull.
> 
I can suggest to try the current 2.6, on which 8272 is supported and 
known to work. A problem with binary you got is possibly because of 
configuration incompatibility of your u-boot and kernel binary.


>  
> 
>  
> 
> *=> tftp 100000 vmlinux.72*
> 
> *Using FCC1 ETHERNET device*
> 
> *TFTP from server 10.0.0.1; our IP address is 10.0.0.2*
> 
> *Filename 'vmlinux.72'.*
> 
> *Load address: 0x100000*
> 
> *Loading: #################################################################*
> 
> *         #################################################################*
> 
> *         #######################*
> 
> *done*
> 
> *Bytes transferred = 782424 (bf058 hex)*
> 
> *=> bootm 100000*
> 
> *## Booting image at 00100000 ...*
> 
> *   Image Name:   Linux-2.4.22*
> 
> *   Image Type:   PowerPC Linux Kernel Image (gzip compressed)*
> 
> *   Data Size:    782360 Bytes = 764 kB*
> 
> *   Load Address: 00000000*
> 
> *   Entry Point:  00000000*
> 
> *   Verifying Checksum ... OK*
> 
> *   Uncompressing Kernel Image ... OK*
> 
> *                                                                                
> *
> 
> *                                                                                
> *
> 
> *U-Boot 1.1.1 (Nov  8 2005 - 16:19:13)*
> 
> *                                                                                
> *
> 
> *MPC8272 Reset Status: Check Stop, External Soft, External Hard*
> 
> *                                                                                
> *
> 
> *MPC8272 Clock Configuration*
> 
> * - Bus-to-Core Mult 3.5x, VCO Div 2, 60x Bus Freq  30-85 , Core Freq 
> 100-300*
> 
> * - dfbrg 1, corecnf 0x1e, busdf 3, cpmdf 1, plldf 0, pllmf 3*
> 
> * - vco_out  400000000, scc_clk  100000000, brg_clk   25000000*
> 
> * - cpu_clk  350000000, cpm_clk  200000000, bus_clk  100000000*
> 
> * - pci_clk   66666666*
> 
> *                                                                                
> *
> 
> *CPU:   MPC8272 (HiP7 Rev 14, Mask A.0 1K50M) at 350 MHz*
> 
> *Board: Motorola MPC8272ADS*
> 
> *DRAM:  64 MB*
> 
> *FLASH:  8 MB*
> 
> *In:    serial*
> 
> *Out:   serial*
> 
> *Err:   serial*
> 
> *Net:   FCC1 ETHERNET*
> 
> *Hit any key to stop autoboot:  0*
> 
> *=>*
> 
>  
> 
>  
> 
> Best Regards
> 
>  
> 
> Srideep
> 
>  
> 
> 
> Confidentiality Notice
> 
> The information contained in this electronic message and any attachments 
> to this message are intended
> for the exclusive use of the addressee(s) and may contain confidential 
> or privileged information. If
> you are not the intended recipient, please notify the sender at Wipro or 
> Mailadmin@wipro.com immediately
> and destroy all copies of this message and any attachments.
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
