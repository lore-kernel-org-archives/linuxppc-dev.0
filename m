Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.251])
	by ozlabs.org (Postfix) with ESMTP id CB2A1DDDF2
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Sep 2007 00:48:02 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c37so300994anc
	for <linuxppc-dev@ozlabs.org>; Tue, 04 Sep 2007 07:47:58 -0700 (PDT)
Message-ID: <fa686aa40709040747j503a2054x27ba2b8146a93ff8@mail.gmail.com>
Date: Tue, 4 Sep 2007 08:47:57 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Thomas Gerlach" <gerlach@kip.uni-heidelberg.de>
Subject: Re: Newbie on embedded linux on PPC: error: cannot find boot.o
In-Reply-To: <46DD6238.6030204@kip.uni-heidelberg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <46DD6238.6030204@kip.uni-heidelberg.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 9/4/07, Thomas Gerlach <gerlach@kip.uni-heidelberg.de> wrote:
> hi folks,
>
>
> my name is thomas trying to make embedded linux run on a powerpc, but we've got special boards here, although we use a xilinx virtex4 fpga...
>
> as you said in the nabble-thread (see subject), i set up edk9.1 software platform settings und ran libgen to get the xparameters* files. i copied those bsp files into the kernel tree (i use your kernel linux-2.6-virtex from git.secretlabs.ca/git). after configuring the kernel settigs, i try
>
> $ make ARCH=ppc CROSS_COMPILE=powerpc-eabi-

You should be using a Linux cross compiler, not powerpc-eabi-.  The
Xilinx cross compiler will not work to compile Linux kernels.

You can build yourself a cross compiler using 'crosstool':
http://www.kegel.org/crosstool.

Alternately, you can download ELDK:
http://www.denx.de/wiki/view/DULG/ELDKAvailability

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
