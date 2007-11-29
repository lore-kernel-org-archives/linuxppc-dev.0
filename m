Return-Path: <dale@farnsworth.org>
Received: from farnsworth.org (xyzzy.farnsworth.org [65.39.95.219])
	by ozlabs.org (Postfix) with SMTP id 4BF2EDDE9B
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 30 Nov 2007 03:10:43 +1100 (EST)
Date: 29 Nov 2007 09:09:43 -0700
Message-ID: <20071129160943.15336.qmail@farnsworth.org>
From: "Dale Farnsworth" <dale@farnsworth.org>
To: linuxppc-embedded@ozlabs.org
Subject: Re: The question about the high memory support on MPC8360?
In-Reply-To: <f87675ee0711290459r20aa606ak7b3be9d3b0a8ec1c@mail.gmail.com>
References: <396305910.05464@tsinghua.org.cn> <474E6A58.2070200@gdatech.co.in>
Cc: 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Robert lazarski wrote:
> On Nov 29, 2007 2:29 AM, vijay baskar <cn.vijaibaskar@gdatech.co.in> wrote:
> >
> >  How to make the linux find the total 2GB memory?
> >
> >         Hi Friend,
> >
> >  I hope u had tracked the conversion that has been going on. The max mem
> > that the kernel can show is only 768 MB because only that of memory is
> > directly mapped with your ram.. No matter how much ram > 768 MB (in
> > powerpc.. it varies in other architectures) u have, the kernel will show
> > only 768 MB.. This is called low mem..
> >
> >  How t o use high mem??
> >
> >  scott can probably guide us on this.. I also have lot of confusions about
> > high mem.. Also i would suggest you a bit of reading on virtual memory
> > management on linux to get a grasp about how things are done
> >  Rest for scott
> >
> >  regards,
> >  vijai
> 
> I also have a requirement to use more than 768MB and 0x30000000. I
> have other problems at the moment, so I haven't tested this completely
> yet. My limited understanding, though, is that to use more than 768MB
> you have to change your kernel configuration, including shifting the
> kernel start address. This is what I plan on testing for 1GB when I
> have time:
> 
> CONFIG_ADVANCED_OPTIONS=y
> CONFIG_LOWMEM_SIZE_BOOL=y
> CONFIG_LOWMEM_SIZE=0x40000000
> CONFIG_KERNEL_START_BOOL=y
> CONFIG_KERNEL_START=0xa0000000
> # CONFIG_CONSISTENT_START_BOOL is not set
> # CONFIG_CONSISTENT_SIZE_BOOL is not set
> # CONFIG_BOOT_LOAD_BOOL is not set
> 
> If that works for current kernels, please respond to the list ;-) .

Can't answer that question, but before trying that, have you tried
CONFIG_HIGHMEM=y ?

-Dale
