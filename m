Content-Type: text/plain;
  charset="iso-8859-1"
From: Rakesh jagota <j.rakesh@gdatech.co.in>
Reply-To: j.rakesh@gdatech.co.in
To: Chris Zimman <chris@cryptoapps.com>
Subject: Re: Problem with kernel loading in PPC IBM405 based board
Date: Fri, 7 Nov 2003 09:06:34 +0530
Cc: linuxppc-embedded@lists.linuxppc.org
References: <f4sdizk28w071ij.110620032000@gda-server> <20030611151322.GA9573@dingdong.cryptoapps.com>
In-Reply-To: <20030611151322.GA9573@dingdong.cryptoapps.com>
MIME-Version: 1.0
Message-ID: <agl575xzx4jdocg.120620030900@gda-server>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

I am using openBios code, but i m not able to load the zImage.treeboot using
tftp or serial port. I am directly loading the zImage.treeboot using JTAG
(RISCWATCH). But I am not able to find out the exact loaction where we should
load the image and then from where should be start running the kernel. I have
seen the stext loaction (0xc0000000). Can you guide me exactly where should I
load this image.

Thanks & Regards,

Rakesh

On Wednesday 11 June 2003 08:43 pm, Chris Zimman wrote:
> On Thu, Nov 06, 2003 at 08:05:59PM +0530, Rakesh jagota wrote:
> > Hi all,
> > I am working on PPC IBM 405 based processor board. I have kernel from
> > "montavista" 2.4.17-mv121 version. I have tried to put the vmlinux image
> > in the "SDRAM" after doing the all initialization (in boot level).
> >
> > We are loading the vmlinux in SDRAM at 0x00020000. I am not able to see
> > any debug message on the serial port. I am not sure about the kernel jump
> > location. Is there any way to find out the exact location to load the
> > kernel and jump to proper location.
>
> You can't just boot vmlinux directly -- depending on which boot monitor
> you're using (eg. OSOpen, PPC/UBoot) you need to be using a different
> kernel image.  If you're using OSOpen, you need zImage.treeboot.  If you're
> using PPCBoot/UBoot, you need pImage.
>
> --Chris


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
