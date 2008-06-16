Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 02D40DE141
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 17 Jun 2008 02:45:51 +1000 (EST)
Message-Id: <AC9D0DC1-82AD-4C23-AE09-C278E53D7AB0@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Marco Stornelli <marco.stornelli@coritel.it>
In-Reply-To: <485683B7.5030407@coritel.it>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: MPC8641D Msi
Date: Mon, 16 Jun 2008 11:45:41 -0500
References: <485683B7.5030407@coritel.it>
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


On Jun 16, 2008, at 10:16 AM, Marco Stornelli wrote:

> Hi,
>
> I've got a device connected with Pci-express to an mpc8641d_hpcn  
> evaluation board (rev. 2.0) and I'm using the latest kernel. This  
> device use MSI to generate an interrupt, but it seems possible that  
> the only MSI that can be triggered through the standard PCI Express  
> is interrupt 0. Is there a way to solve it? Some workaround or  
> something like it?

what exactly do you mean by using the latest kernel?  The powerpc-next  
tree or 2.6.26?

- k
