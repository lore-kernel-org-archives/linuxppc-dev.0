Return-Path: <leon.woestenberg@gmail.com>
Received: from mail-fx0-f228.google.com (mail-fx0-f228.google.com
	[209.85.220.228]) by ozlabs.org (Postfix) with ESMTP id C443CB7B7A
	for <linuxppc-dev@ozlabs.org>; Sun, 20 Sep 2009 04:31:20 +1000 (EST)
Received: by fxm28 with SMTP id 28so1478269fxm.41
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Sep 2009 11:31:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4AB1B84F.8080606@embedded-sol.com>
References: <4AB1B84F.8080606@embedded-sol.com>
Date: Sat, 19 Sep 2009 20:31:17 +0200
Message-ID: <c384c5ea0909191131g1d485ad9t3b108a29fcfef1d9@mail.gmail.com>
Subject: Re: FPGA access over PCI-E on MPC8536
From: Leon Woestenberg <leon.woestenberg@gmail.com>
To: Felix Radensky <felix@embedded-sol.com>, Greg KH <gregkh@suse.de>,
	Greg KH <greg@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Felix,

On Thu, Sep 17, 2009 at 6:17 AM, Felix Radensky <felix@embedded-sol.com> wrote:
> On my custom MPC8536 based board running 2.6.31 kernel
> FPGA is connected via x2 PCI-E lane. FPGA is identified
> during PCI scan and is visible via lspci.
>

I committed a PCI Express device driver for an Altera FPGA (chaining
DMA reference) design upstream that resides in the upstream Linux
kernel at drivers/staging/altpciechdma/

It can act as a reference for the generic part of your design.

Regards,
-- 
Leon
