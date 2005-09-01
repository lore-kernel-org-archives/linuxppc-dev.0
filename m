Return-Path: <tnt@246tNt.com>
Received: from outmx010.isp.belgacom.be (outmx010.isp.belgacom.be
	[195.238.3.233])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2475F6815D
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  2 Sep 2005 00:28:39 +1000 (EST)
Received: from outmx010.isp.belgacom.be (localhost [127.0.0.1])
	by outmx010.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id j81ESV86017347
	for <linuxppc-embedded@ozlabs.org>; Thu, 1 Sep 2005 16:28:32 +0200
	(envelope-from <tnt@246tNt.com>)
Message-ID: <43171071.40400@246tNt.com>
Date: Thu, 01 Sep 2005 16:30:09 +0200
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: John F Davis <johndavi@us.ibm.com>
References: <OF4A6E57B7.047A8CB6-ON8725706F.00264CE2-C125706F.00264A01@us.ibm.com>
In-Reply-To: <OF4A6E57B7.047A8CB6-ON8725706F.00264CE2-C125706F.00264A01@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: linux hangs after uncompress kernel image
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Or take the address of the __log_buf symbol then after the crash,
reboot and dump the buffer there, so you can see erly printk (before
console is up).

	Sylvain


John F Davis wrote:
> 
> Hello Lily,
> 
> Maybe you could try to put in some printk's and see which line of code
> generates an exception.
> 
> JD
> 
> 
> *"lily" <lichanjuan04@st.lzu.edu.cn>*
> Sent by: linuxppc-embedded-bounces@ozlabs.org
> 
> 09/01/2005 05:55 AM
> 
> 	
> To
> 	<linuxppc-embedded@ozlabs.org>
> cc
> 	
> Subject
> 	linux hangs after uncompress kernel image
> 
> 
> 	
> 
> 
> 
> 
> 
> i work on octobusHPPC405EP board . when I try to bring up the kernel i
> meet the problem that linux hangs after uncompressing image:
>  
> U-Boot 1.1.2 (Jun  3 2005 - 12:05:48)
>  
> CPU:   IBM PowerPC 405EP Rev. B at 133.333 MHz (PLB=133, OPB=66, EBC=33 MHz)
>       IIC Boot EEPROM disabled
>       PCI async ext clock used, internal PCI arbiter enabled
>       16 kB I-Cache 16 kB D-Cache
> OCTOBUS Board: ### No HW ID - assuming OCTOBUS HPPC405
> I2C:   ready
> DRAM:  32 MB
> FLASH:  4 MB
> =>iminfo 1000000
> ## Checking Image at 01000000 ...
>   Image Name:   Linux-2.4.21-pre5
>   Created:      2005-08-03  17:45:20 UTC
>   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>   Data Size:    548345 Bytes = 535.5 kB
>   Load Address: 00000000
>   Entry Point:  00000000
>   Verifying Checksum ... OK
> => bootm 1000000
> ## Booting image at 01000000 ...
>   Image Name:   Linux-2.4.21-pre5
>   Created:      2005-08-03  17:45:20 UTC
>   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>   Data Size:    548345 Bytes = 535.5 kB
>   Load Address: 00000000
>   Entry Point:  00000000
>   Verifying Checksum ... OK
>   Uncompressing Kernel Image ... OK
> 
> <hang>
> what's the problem?? _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
