Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 8686B67A79
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  8 Mar 2005 12:46:37 +1100 (EST)
In-Reply-To: <20050308012941.8430A67A67@ozlabs.org>
References: <20050308012941.8430A67A67@ozlabs.org>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <ea2b3a6bc9b91cf664530fa855ba0c59@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Mon, 7 Mar 2005 19:46:28 -0600
To: "leo" <leo_guo@jisung.cn>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: MPC82XX and SATA hardisk performance.
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Have you tried bonnie++  (http://www.coker.com.au/bonnie++/)

- kumar

On Mar 7, 2005, at 7:22 PM, leo wrote:

> Hi all,
>  =A0=A0=A0=A0=A0=A0=A0 I use the PCI bus and PCI-SATA bridge SII3112 =
to expand two=20
> SATA port, my MPC8250 work frequency is CORE/CPM/BUS 200/133/66M,=20
> filesystem use ext2 under linux, i write a program to test the maxmium=20=

> written speed, the result is about 60MBps/S, maybe it's too slow?=A0=20=

> Anyone who has experience can give me some advice? How can I increase=20=

> the written speed?
>
> Best Regards!
>
> Leo.
>
> _______________________________________________
> Linuxppc-embedded mailing list
>  Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
