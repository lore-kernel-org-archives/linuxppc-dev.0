Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9C227DDE23
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 01:51:16 +1000 (EST)
Message-ID: <46488562.4080502@freescale.com>
Date: Mon, 14 May 2007 10:50:58 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] U-boot passes the initrd as start/end, not start/size.
References: <20070511175202.GA14644@ld0162-tx32.am.freescale.net>
	<20070512134529.fe14f441.sfr@canb.auug.org.au>
In-Reply-To: <20070512134529.fe14f441.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stephen Rothwell wrote:
> On Fri, 11 May 2007 12:52:03 -0500 Scott Wood <scottwood@freescale.com> wrote:
> 
>> 	loader_info.initrd_addr = r4;
>>-	loader_info.initrd_size = r4 ? r5 : 0;
>>+	loader_info.initrd_size = r4 ? r5 - r4 : 0;
> 
> 
> So do we need a "+ 1" here, or does r5 contain the address past the initrd?

It includes the address past the initrd.

-Scott
