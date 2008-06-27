Return-Path: <john.williams@petalogix.com>
Received: from hu-out-0506.google.com (hu-out-0506.google.com [72.14.214.230])
	by ozlabs.org (Postfix) with ESMTP id 58DB1DDEF9
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jun 2008 10:12:11 +1000 (EST)
Received: by hu-out-0506.google.com with SMTP id 34so647912hue.9
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jun 2008 17:12:09 -0700 (PDT)
Message-ID: <1d3f23370806261712s5251253cs5f9c8d6614184bae@mail.gmail.com>
Date: Fri, 27 Jun 2008 10:12:07 +1000
From: "John Williams" <john.williams@petalogix.com>
To: "Adrian Bunk" <bunk@kernel.org>
Subject: Re: Microblaze init port v4
In-Reply-To: <20080626150121.GB22025@cs181140183.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1214483429-32360-1-git-send-email-monstr@seznam.cz>
	<20080626150121.GB22025@cs181140183.pp.htv.fi>
Cc: linux-arch@vger.kernel.org, vapier.adi@gmail.com, arnd@arndb.de,
	matthew@wil.cx, microblaze-uclinux@itee.uq.edu.au,
	linux-kernel@vger.kernel.org, drepper@redhat.com,
	linuxppc-dev@ozlabs.org, will.newton@gmail.com, hpa@zytor.com,
	monstr@seznam.cz, John.Linn@xilinx.com, alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

On 6/27/08, Adrian Bunk <bunk@kernel.org> wrote:
> On Thu, Jun 26, 2008 at 02:29:29PM +0200, monstr@seznam.cz wrote:

>  > current linux version is 2.6.26-rc8 and I think this is the right time
>  > to send latest patches againts rc8 for Microblaze CPU.
>  >...
>
>  Thanks for your work on getting the architecture included.
>
>  I have two questions:
>
>  Where can I find a toolchain for compiling a Microblaze kernel?

We bundle it in the PetaLinux distro:

http://developer.petalogix.com

>  What is the status of Microblaze support in upstream binutils and gcc?

noMMU uClibc toolchain is at 3.4.1, MMU/glibc is at 4.1.1  Xilinx does
their gcc/binutils stuff mostly in-house, and none of it is upstream.
We (PetaLogix) build and distribute the uClibc toolchain, and we are
slowly merging the MMU support across to our regular distro, that will
also include the glibc tools.

Cheers,

John
-- 
John Williams, PhD, B.Eng, B.IT
PetaLogix - Linux Solutions for a Reconfigurable World
w: www.petalogix.com  p: +61-7-30090663  f: +61-7-30090663
