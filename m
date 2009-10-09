Return-Path: <roberto.j.guerra@gmail.com>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.150])
	by ozlabs.org (Postfix) with ESMTP id B16A9B7B7D
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 10 Oct 2009 05:08:10 +1100 (EST)
Received: by qw-out-1920.google.com with SMTP id 4so2329573qwk.50
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 09 Oct 2009 11:08:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20091009170433.GA17372@b07421-ec1.am.freescale.net>
References: <7c4144600910090714g524bad07ubf6cad3aaf8085ff@mail.gmail.com>
	<20091009170433.GA17372@b07421-ec1.am.freescale.net>
Date: Fri, 9 Oct 2009 13:59:58 -0400
Message-ID: <7c4144600910091059o492c870cn3ea1c1a96d2f0823@mail.gmail.com>
Subject: Re: Support for S29JL064 in MPC8272ADS?
From: Roberto Guerra <roberto.j.guerra@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

No. I did not. My FDT was simplified from the stock MPC8272ADS:
=> fdt list
/ {
        model = "pq2fads";
        compatible = "fsl,pq2fads";
        #address-cells = <0x00000001>;
        #size-cells = <0x00000001>;
        cpus {
        };
        memory {
        };
        soc@f0000000 {
        };
        chosen {
        };
};
I am searching how I could add the mtd branch between the "soc" and
the "chosen".

On Fri, Oct 9, 2009 at 1:04 PM, Scott Wood <scottwood@freescale.com> wrote:
> On Fri, Oct 09, 2009 at 10:14:56AM -0400, Roberto Guerra wrote:
>> Hello,
>> My uboot can read my flash chip, finding the uImage and the initramfs,
>> and booting the kernel fine. However, I'd like the Linux kernel to
>> read my flash chip so that it can update files in it.
>
> Have you described your flash chip in the device tree?
>
>> However, the kernel does not detect any flash chip (nor there's any
>> indication that a CFI probe is being performed).
>
> The stock device tree for mpc8272ads only specifies it as a JEDEC
> flash, not CFI.
>
> -Scott
>
