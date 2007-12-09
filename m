Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.249])
	by ozlabs.org (Postfix) with ESMTP id 19739DDE22
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  9 Dec 2007 17:19:01 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so279707anc
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 08 Dec 2007 22:18:59 -0800 (PST)
Message-ID: <fa686aa40712082218k7e520e45q1266ecb4692b7dbb@mail.gmail.com>
Date: Sat, 8 Dec 2007 23:18:59 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Jean-Samuel Chenard" <jsamch@macs.ece.mcgill.ca>
Subject: Re: Xilinx ML310 Linux 2.6 PCI bridge
In-Reply-To: <169c03cb0712082151k74e504bvc6e21bb57534ef28@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <169c03cb0712082151k74e504bvc6e21bb57534ef28@mail.gmail.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 12/8/07, Jean-Samuel Chenard <jsamch@macs.ece.mcgill.ca> wrote:
> Hi,
>
> Thanks to the valuable information provided by this discussion group and
> particularly by Grant Likely from Secret Lab Technologies, I was able to
> setup and run Linux 2.6 on my ML-310 development platform.

Congratulations.  If you had to make any changes to get it to work
then please send me your patches.

>
>  On the ML-310, if I want to use the Ethernet port and some other
> peripherals, I need to go through the PCI bus via the opb_pci core on the
> FPGA.
>
> However, when I enable PCI support in the kernel, I get the following error
> messages:

You'll have to go back into the mailing list archives to find a patch
for adding PCI support for a Virtex platform.  I don't have any of
that in my tree.  It probably only exists for the 2.4 kernel.  You'll
need to port forward to use it on 2.6 (I'm more than willing to help
you with this)

However, word of warning.  The Xilinx PCI bridge is badly broken.
Xilinx is not supporting the PCI core and it is missing the ability to
do certain types of transfers.  Last I heard, Xilinx has no plans to
fix their PCI core either.

Best of luck,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
