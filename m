Return-Path: <jcm@jonmasters.org>
Received: from smtp.mailbox.co.uk (smtp.mailbox.net.uk [195.82.125.32])
	by ozlabs.org (Postfix) with ESMTP id 4060A2BC0F
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 15 Oct 2004 07:24:11 +1000 (EST)
Date: Thu, 14 Oct 2004 22:23:44 +0100
From: Jon Masters <jonathan@jonmasters.org>
To: Rupesh S <rupesh.sugathan@gmail.com>
Message-ID: <20041014212344.GA789@apogee.jonmasters.org>
References: <1e44ebcf04101214247d3072b6@mail.gmail.com>
	<20041012213634.GA4936@gate.ebshome.net>
	<35fb2e590410121603624c27a2@mail.gmail.com>
	<1e44ebcf0410140944620f1dab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1e44ebcf0410140944620f1dab@mail.gmail.com>
Sender: Jon Masters <jcm@jonmasters.org>
Cc: jonathan@jonmasters.org, linuxppc-embedded@ozlabs.org
Subject: Re: PPC kernel hangs
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Oct 14, 2004 at 09:44:30AM -0700, Rupesh S wrote:

> ################################################################
> volatile __u32* __fpga;
> 
> __fpga = (__u32*) ioremap_nocache(0x60000000, (4*1024));
> 
> /* writel(data, ((__u32)__fpga + 0x0C)); */ /* This does not work */
> 
> *(volatile __u32*)((__u32)__fpga + 0x0C) = data; /* This works */
> #############################################################

Hi Rupesh,

Notice that you're casting as a pointer in one case, and in the other you're not.

Jon.
