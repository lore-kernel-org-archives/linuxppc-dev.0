Return-Path: <jonsmirl@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.182])
	by ozlabs.org (Postfix) with ESMTP id 3DCBCDDDE4
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 18 Aug 2007 12:33:47 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m34so56607wag
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 17 Aug 2007 19:33:46 -0700 (PDT)
Message-ID: <9e4733910708171933y68347f14n46bd6b857fbba9f4@mail.gmail.com>
Date: Fri, 17 Aug 2007 22:33:46 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Booting new MPC5200B board
In-Reply-To: <9e4733910708171247n15475e4l2c86cade776d3fb3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910708171247n15475e4l2c86cade776d3fb3@mail.gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 8/17/07, Jon Smirl <jonsmirl@gmail.com> wrote:
> I'm using OSELAS-tiny-5 to compile a kernel for my new Phytec
> 5200B-tiny board with u-boot. When I try booting the kernel via tftpd
> I get this error about the RAMDisk. Why does it want a RAMDisk, and
> how do I supply it with one?

The problem with the RAMDisk error is caused by the board shipping
with uboot 1.1.4. Upgrading to 1.2.0 fixes it.

1.1.4 doesn't implement dtb support
 bootm 0x500000 - 0x400000
gets interpreted as load a RAM disk at 00000.

-- 
Jon Smirl
jonsmirl@gmail.com
