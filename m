Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 29CE76889F
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 Dec 2005 02:18:05 +1100 (EST)
In-Reply-To: <20051219085747.5D79425C7AA@smtp-out.completel.net>
References: <20051219085747.5D79425C7AA@smtp-out.completel.net>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <AD798914-F1FD-4143-A312-D31BE12B1188@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Date: Mon, 19 Dec 2005 09:18:05 -0600
To: Nathael Pajani <nathael.pajani@cpe.fr>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] powerpc: CPM2 interrupt handler failure after 100,000
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Dec 19, 2005, at 3:00 AM, Nathael Pajani wrote:

>  interrupts
> Message-Id: <20051219100059.5a95533f.nathael.pajani@cpe.fr>
> X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.9; i486-pc-linux-gnu)
> Mime-Version: 1.0
> Content-Type: text/plain; charset=ISO-8859-1
> Content-Transfer-Encoding: quoted-printable
>
> Hi!
>
> Hum.. in the patch you moved from "void" to "int":
>> -static void cpm2_cascade(int irq, void *dev_id, struct pt_regs  
>> *regs)
>> +static int cpm2_cascade(int irq, void *dev_id, struct pt_regs *regs)
>
> But should'nt it be "irqreturn_t" ?
> static irqreturn_t cpm2_cascade(int irq, void *dev_id, struct  
> pt_regs *regs)

Yep, should be.  I'll fixup the patch and resend.

- kumar
