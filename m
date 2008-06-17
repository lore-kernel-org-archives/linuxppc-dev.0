Return-Path: <marco.stornelli@coritel.it>
Received: from nausicaa2.coritel.it
	(host254-130-static.190-82-b.business.telecomitalia.it
	[82.190.130.254]) by ozlabs.org (Postfix) with ESMTP id AD368DDE0E
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 17 Jun 2008 16:38:29 +1000 (EST)
Message-ID: <48575C67.7070602@coritel.it>
Date: Tue, 17 Jun 2008 08:40:39 +0200
From: Marco Stornelli <marco.stornelli@coritel.it>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: MPC8641D Msi
References: <485683B7.5030407@coritel.it>
	<AC9D0DC1-82AD-4C23-AE09-C278E53D7AB0@kernel.crashing.org>
In-Reply-To: <AC9D0DC1-82AD-4C23-AE09-C278E53D7AB0@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Cc: LinuxPPC-Embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Kumar Gala ha scritto:
> 
> On Jun 16, 2008, at 10:16 AM, Marco Stornelli wrote:
> 
>> Hi,
>>
>> I've got a device connected with Pci-express to an mpc8641d_hpcn 
>> evaluation board (rev. 2.0) and I'm using the latest kernel. This 
>> device use MSI to generate an interrupt, but it seems possible that 
>> the only MSI that can be triggered through the standard PCI Express is 
>> interrupt 0. Is there a way to solve it? Some workaround or something 
>> like it?
> 
> what exactly do you mean by using the latest kernel?  The powerpc-next 
> tree or 2.6.26?
> 
> - k
> 
kernel 2.6.25.7, but I think it isn't a kernel problem but an hardware 
problem instead, so I wondered if there's a patch for that problem.

-- 
Marco Stornelli
Embedded Software Engineer
CoRiTeL - Consorzio di Ricerca sulle Telecomunicazioni
http://www.coritel.it

marco.stornelli@coritel.it
+39 06 72582838
