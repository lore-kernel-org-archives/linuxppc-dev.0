Return-Path: <gvb.linuxppc.dev@gmail.com>
Received: from QMTA01.westchester.pa.mail.comcast.net
	(qmta01.westchester.pa.mail.comcast.net [76.96.62.16])
	by ozlabs.org (Postfix) with ESMTP id 6C0CEDDF0E
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Aug 2008 12:24:24 +1000 (EST)
Message-ID: <489BAE69.9010400@gmail.com>
Date: Thu, 07 Aug 2008 22:24:41 -0400
From: Jerry Van Baren <gvb.linuxppc.dev@gmail.com>
MIME-Version: 1.0
To: surendranath.moilla@cmcltd.com
Subject: Re: problem in booting kernel with mpc836x_mds.dtb
References: <19152.136.182.158.153.1218051991.squirrel@webmail.cmcltd.com>
In-Reply-To: <19152.136.182.158.153.1218051991.squirrel@webmail.cmcltd.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

surendranath.moilla@cmcltd.com wrote:
> Hi,
>    I have the following problem, when i am trying to boot linux on
> MPC8360E MDS board with the mpc836x_mds.dtb created using dtc and
> mpc836x_mds.dts in from /arch/powerpc/boot/platforms/dts/ directory of
> linux-2.6.22 version.
> 
> fdt_chosen: FDT_ERR_BADMAGIC
> 
> after this it is trying to re boot.
> how to resolve this issue, so i need to apply any pathces to
> mpc836x_mds.dts file.
> NOTE: i am using dtc compiled from linux-2.6.26 version.
> 
> Regards
> Surendra

Hi Surendra,

Is the error message coming from u-boot or linux?  More lines from the 
boot sequence (like most or all of them) would be useful.

The error message is saying that whatever you are passing to the kernel 
(or setting in u-boot with "fdt addr") for your dtb blob is not a valid 
dtb blob.  Display memory where you think your blob resides: if it 
doesn't have 0xd00dfeed in that location, it isn't a valid binary blob. 
  I suspect you will find either you didn't compile your .dts file 
correctly or your blob address is wrong.

If you gave us your dtc command line, that might be helpful.

HTH,
gvb
