Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <19215.14808.476221.223143@drongo.ozlabs.ibm.com>
Date: Fri, 27 Nov 2009 13:30:48 +1100
From: Paul Mackerras <paulus@samba.org>
To: Li Yang <leoli@freescale.com>
Subject: Re: [RFC] powerpc/mm: honor O_SYNC flag for memory map
In-Reply-To: <2a27d3730911252343j6a938d99n7152b7cc8d01c0bf@mail.gmail.com>
References: <1258441832-20133-1-git-send-email-leoli@freescale.com>
	<8543954E-619A-4A78-A934-CDC326027FD2@kernel.crashing.org>
	<3A45394FD742FA419B760BB8D398F9EDCBC1F2@zch01exm26.fsl.freescale.net>
	<1258707833.2140.865.camel@pasglop>
	<2a27d3730911200123i23fa6dd1td9e19944d1737e73@mail.gmail.com>
	<DFC7BA62-6CF0-4A08-8DD1-11825A638262@kernel.crashing.org>
	<2a27d3730911250007s62f31673p3358631996e8a451@mail.gmail.com>
	<20091125113023.GC12738@iram.es>
	<2a27d3730911252343j6a938d99n7152b7cc8d01c0bf@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, Li Yang-R58472 <r58472@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Li Yang writes:

> That's my concern too.  But after all mmap without O_SYNC on I/O
> devices should be deprecated.

It should?  Why?

Shouldn't the onus rather be on those proposing an incompatible change
to the kernel ABI, such as this is, to show why the change is
absolutely essential?

>  A warning message in deprecation period
> could reduce potential problem caused by this change.

Not making the change at all would reduce the potential problems even
further. :)

Paul.
