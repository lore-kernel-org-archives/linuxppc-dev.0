Return-Path: <kashiwagi@co-nss.co.jp>
Received: from nssinet2.co-nss.co.jp (nssinet2.co-nss.co.jp [150.96.0.5])
	by ozlabs.org (Postfix) with ESMTP id 0DF8E68878
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  7 Dec 2005 22:57:24 +1100 (EST)
Received: from nssinet2.co-nss.co.jp (localhost [127.0.0.1])
	by nssinet2.co-nss.co.jp (8.9.3/3.7W) with ESMTP id UAA23927
	for <linuxppc-embedded@ozlabs.org>; Wed, 7 Dec 2005 20:16:38 +0900 (JST)
Received: from nssnet.co-nss.co.jp (nssnet.co-nss.co.jp [150.96.64.250])
	by nssinet2.co-nss.co.jp (8.9.3/3.7W) with ESMTP id UAA23923
	for <linuxppc-embedded@ozlabs.org>; Wed, 7 Dec 2005 20:16:37 +0900 (JST)
Received: from [192.168.11.4] ([150.96.64.155])
	by nssnet.co-nss.co.jp (8.9.3+Sun/3.7W) with SMTP id UAA17520
	for <linuxppc-embedded@ozlabs.org>; Wed, 7 Dec 2005 20:12:36 +0900 (JST)
MIME-Version: 1.0
Date: Wed, 07 Dec 2005 20:31:30 +0900
From: Yoshio Kashiwagi <kashiwagi@co-nss.co.jp>
To: linuxppc-embedded@ozlabs.org
Message-ID: <JL200512072031305.24244812@co-nss.co.jp>
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <259581790512070010s3be8b3cfg6cfd17d2f503b0f7@mail.gmail.com>
References: <259581790512070010s3be8b3cfg6cfd17d2f503b0f7@mail.gmail.com>
Subject: Re: linux 2.4 on Xilinx ml403
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

libgen of EDK should generate the definition of
XPAR_INTC_0_SYSACE_0_VEC_ID as follows according to your design to
xparameters.h.

[snip]
#define XPAR_INTC_0_SYSACE_0_VEC_ID XPAR_OPB_INTC_0_SYSACE_COMPACTFLASH_
SYSACE_IRQ_INTR
[snip]

Have you copied xparameters.h which EDK generated to the kernel tree?

Best Regards,

Yoshio Kashiwagi

> Hi all,
> 
> I have been trying to run linux 2.4.26 on Virtex 4 for a while and 
without
> success.
> 
> I am trying to implement a simple design, with an UART, SystemACE and
> everything interrupt driven. When I try to make bzImage, there is an 
error
> in (SysACE) adapter.c file, because XPAR_INTC_0_SYSACE_0_VEC_ID is not
> defined.
> 
> I have applied the patch given by Xilinx for switching from the ml300 
to the
> ml403, which copies the bsp, .config and xparameter files into the 
kernel.
> 
> I am stucked here, and do not know how to keep going from that.
> Could anyone help me a little bit?
> 
> Thanks and have a good day!
> 
