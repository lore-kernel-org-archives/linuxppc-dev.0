Return-Path: <glikely@secretlab.ca>
Received: from mail-yx0-f175.google.com (mail-yx0-f175.google.com
	[209.85.210.175]) by ozlabs.org (Postfix) with ESMTP id AC3B7B7CE6
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Feb 2010 15:31:19 +1100 (EST)
Received: by yxe5 with SMTP id 5so504726yxe.17
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Feb 2010 20:31:18 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <8f766422-4c34-416e-9ae1-95fac2586cdb@SG2EHSMHS006.ehs.local>
References: <8f766422-4c34-416e-9ae1-95fac2586cdb@SG2EHSMHS006.ehs.local>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 26 Feb 2010 21:30:58 -0700
Message-ID: <fa686aa41002262030h74e0f9bq4b1575228f373e56@mail.gmail.com>
Subject: Re: PCI NIC for powerpc system
To: John Linn <John.Linn@xilinx.com>
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

On Fri, Feb 26, 2010 at 6:57 PM, John Linn <John.Linn@xilinx.com> wrote:
> Hi,
>
> I should apologize ahead of time for my lack of knowledge with PCI.
>
> I'm trying to better understand if I can run a standard off the shelf
> PCI NIC with a powerpc kernel as the PCI with device tree is not clear
> to me.

yes.

> I don't see many Ethernet drivers having OF support in them so maybe
> devices on the PCI bus are discovered by the kernel such that the
> drivers don't need to be OF aware.

PCI can be probed, so PCI drivers don't need to be OF aware.

g.
