Return-Path: <vbordug@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 35E886884B
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  2 Dec 2005 21:30:23 +1100 (EST)
Message-ID: <4390223C.8060103@ru.mvista.com>
Date: Fri, 02 Dec 2005 13:30:20 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
MIME-Version: 1.0
To: Alex BASTOS <alebas@televes.com>
References: <1133520697.4390273987a6a@webmail.televes.com:443>
In-Reply-To: <1133520697.4390273987a6a@webmail.televes.com:443>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: pq2_find_bridges hangs system
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Alex BASTOS wrote:
> Hi,
> 
> I am working on a board with a MPC8248 based on ADS8272.
> Until now I was working with ppc kernel 2.6.11. Now, it's
> time to go up, so I am trying 2.6.15-rc2.
> 
> Unfortunately, kernel hangs at boot-up, and with a BDI2000
> I have reached the pq2_find_bridges() call, more precisely,
> in indirect_read_config(). Now I am a bit lost, as I have
> almos any knowledge about PCI.
> 
> The board doesn't need PCI support at all, but I need it
> active on kernel as it is required by USB HCD stack.
> 
> I have tested this on the ADS8272 and i doesn't happends,
> so, any clue.
> 
> And, has the indirect_read_config any to do with the PCI9
> workaround, which is supposed to be corrected on HIP7
> devices?
> 
There are 2 indirect_read_config(), one for PCI9 case, and one for not. 
I guess you should have CONFIG_8260_PCI9 disabled.

If config seems OK, pleas submit backtrace. As long as I can see, "proper" setup_indirect_pci has been moved over to arch/powerpc/sysdev/indirect_pci.c.
Check it it is compiled/used.

> Thanks in advance.
> 
> Alex BASTOS
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 


-- 
Sincerely, 
Vitaly
