Return-Path: <glikely@secretlab.ca>
Received: from qb-out-0506.google.com (qb-out-0506.google.com [72.14.204.236])
	by ozlabs.org (Postfix) with ESMTP id 0B722DDEEF
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Aug 2008 12:49:14 +1000 (EST)
Received: by qb-out-0506.google.com with SMTP id d11so941607qbd.39
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 31 Jul 2008 19:49:13 -0700 (PDT)
Date: Thu, 31 Jul 2008 20:34:12 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Naresh Bhat <nareshgbhat@gmail.com>
Subject: Re: Board is not booting - Please Help me
Message-ID: <20080801023412.GA32426@secretlab.ca>
References: <cf9b3c760807300044y4625ca2am60367defaa98d49b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cf9b3c760807300044y4625ca2am60367defaa98d49b@mail.gmail.com>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Jul 30, 2008 at 01:14:52PM +0530, Naresh Bhat wrote:
> Hi Guys
> I have ML507 board.  By using "ml507_bsb_design_ppc440.zip"
> I have created the "Base System Builder" project and also
> 
> I am able to create the following files sucessfully.
> 
> 1. My own "DTS" file (attached with the mail)
> 2. My own "download.bit" file
> 3. My own ACE file. (Used the Montavista Pro 5.0 kernel., Kernel is compiled
> with ARCH=powerpc, CROSS_COMPILE=ppc_440-, used the ml507_defconfig)

Unfortunately, I'm not able to help much with the Montavista kernel
since I don't know anything about which version it is based on.  Have
you tried using the current mainline kernel source or Xilinx's published
git repo?

To use mainline, try copying your .dts file to
arch/powerpc/boot/dts/virtex440-myml507.dts and then build the kernel
with 'make simpleImage.virtex440-myml507'

g.
