Return-Path: <john.bonesio@xilinx.com>
Received: from SG2EHSOBE006.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80]) by ozlabs.org (Postfix) with ESMTP id 42DABDE1D1
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Apr 2009 02:51:01 +1000 (EST)
Date: Thu, 9 Apr 2009 09:50:54 -0700
From: John Bonesio <john.bonesio@xilinx.com>
MIME-Version: 1.0
To: khollan <khollan@daktronics.com>
Subject: Re: Xilinx board and NPTL support lockup
References: <22960621.post@talk.nabble.com>
In-Reply-To: <22960621.post@talk.nabble.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Message-ID: <20090409165055.AC7A31A78051@mail50-sin.bigfish.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Kevin,

This doesn't look like an NPTL problem to me. It appears you have 
rebuilt the kernel, and your new kernel has a problem booting on the 
board. I would check the configuration options you have enabled in the 
kernel, and I would check that xparameters.h (older kernel) or the 
device-tree (newer kernel) is right for your hardware design.

If you haven't rebuilt the kernel, then I would check your setup.

- John

khollan wrote:
> Hi everyone,
>
> I have a board similar to the ml410, its been running a linux kernel happily
> for about a year now, but now the firmware guys want NPTL threading instead
> of the linuxthread library.
> I recompiled my gcc 4.0.2 and glibc 2.3.6 library with the NPTL support, and
> recompiled my kernel with the new tools.
>
> Now my kernel gets stuck at the infamous "Now Booting the Kernel" message.
>
> Any thoughts on why this might be happening, or how to verify that my glibc
> and gcc are functional other than trying to compile things with them (I know
> this works).
>
> Thanks
> Kevin 
>   

-- 
------------------------------------------------------------------------

John Bonesio
Commercial Linux Solutions
john.bonesio@xilinx.com
(408) 879-5569

This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
