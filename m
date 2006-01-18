Return-Path: <peter.ryser@xilinx.com>
Received: from outbound1-red-R.bigfish.com (outbound-red.frontbridge.com
	[216.148.222.49])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 9A964681BB
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 19 Jan 2006 10:44:21 +1100 (EST)
Message-ID: <43CECEA4.4050908@xilinx.com>
Date: Wed, 18 Jan 2006 15:26:28 -0800
From: Peter Ryser <peter.ryser@xilinx.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 00/10] Updated ML300 & ML403 patches
References: <20060114094658.GA12639@secretlab.ca>
	<43CC5453.3060702@xilinx.com> <43CC9F35.8010305@secretlab.ca>
	<43CCE89B.8050603@xilinx.com> <43CD460F.8010506@secretlab.ca>
In-Reply-To: <43CD460F.8010506@secretlab.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Grant Likely <grant@secretlab.ca>,
	Andrei Konovalov <akonovalov@ru.mvista.com>,
	Rick Moleres <Rick.Moleres@xilinx.com>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


> Yeah, the head of Linus' tree is busted.  Doing a cg-seek 
> 67daf5f11f06b9b15f8320de1d237ccc2e74fe43 will work, but you first need 
> to remove the following line from arch/ppc/kernel/ppc_ksyms.c
>
> EXPORT_SYMBOL(get_wchan);
>
After applying your patches to the branch-point you mention above, 
removing that symbol, and configuring for the ML403 I can get to a boot 
prompt. Good.

Doing the same for the ML300, though, does not work, i.e. I get a single 
line saying:
"Data machine check in kernel mode."

Digging in the kernel configuration I don't seem to find a place where I 
can turn on more verbose output, i.e. a register dump at the time of the 
machine check exception. Any idea where I might find that?

- Peter
