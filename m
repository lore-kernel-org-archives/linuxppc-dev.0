Date: Wed, 11 Jun 2003 10:13:22 -0500
From: Chris Zimman <chris@cryptoapps.com>
To: Rakesh jagota <j.rakesh@gdatech.co.in>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Problem with kernel loading in PPC IBM405 based board
Message-ID: <20030611151322.GA9573@dingdong.cryptoapps.com>
Reply-To: Chris Zimman <chris@cryptoapps.com>
References: <f4sdizk28w071ij.110620032000@gda-server>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f4sdizk28w071ij.110620032000@gda-server>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Nov 06, 2003 at 08:05:59PM +0530, Rakesh jagota wrote:
>
> Hi all,
> I am working on PPC IBM 405 based processor board. I have kernel from
> "montavista" 2.4.17-mv121 version. I have tried to put the vmlinux image in
> the "SDRAM" after doing the all initialization (in boot level).
>
> We are loading the vmlinux in SDRAM at 0x00020000. I am not able to see any
> debug message on the serial port. I am not sure about the kernel jump
> location. Is there any way to find out the exact location to load the kernel
> and jump to proper location.

You can't just boot vmlinux directly -- depending on which boot monitor you're
using (eg. OSOpen, PPC/UBoot) you need to be using a different kernel
image.  If you're using OSOpen, you need zImage.treeboot.  If you're
using PPCBoot/UBoot, you need pImage.

--Chris

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
