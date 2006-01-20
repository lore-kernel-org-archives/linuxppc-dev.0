Return-Path: <avolkov@varma-el.com>
Message-ID: <43D11CEA.7040104@varma-el.com>
Date: Fri, 20 Jan 2006 20:24:58 +0300
From: Andrey Volkov <avolkov@varma-el.com>
MIME-Version: 1.0
To: roman.kuzmenko@auriga.ru
Subject: Re: MPC5200, PCI, udelay(10)
References: <1137745904.4631.17.camel@trust.auriga.ru>
In-Reply-To: <1137745904.4631.17.camel@trust.auriga.ru>
Content-Type: text/plain; charset=us-ascii
Cc: Linuxppc-embedded <Linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Roman Kuzmenko wrote:
> Hello.
> 
> Please, help me to investigate why the delays present in the
> "mpc5xxx_read_config_dword" and "mpc5xxx_write_config_dword" functions
> in the "arch/ppc/kernel/mpc52xx_pci.c" file.
> 
> I.e.
> ==========================
>   *(volatile u32 *)MPC5xxx_PCI_CAR = 0;
>> udelay(10);
>   return 0;
> ==========================
> 
> I was neither able to find any reference at the MPC5200 documentation
> supplied by FreeScale nor reproduce any error with these lines got
> removed.
> 
> Thank you.
> 
kernel version?

--
Regards
Andrey Volkov
