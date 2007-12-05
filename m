Return-Path: <SRS0+7b6c58ac77c6cabb7cfb+1564+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Subject: Re: Merge dtc
From: David Woodhouse <dwmw2@infradead.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <1196807633.13978.383.camel@pmac.infradead.org>
References: <20071016050217.GA9052@localhost.localdomain>
	<1196733544.13978.201.camel@pmac.infradead.org>
	<18261.53985.700234.923526@cargo.ozlabs.ibm.com>
	<1196807633.13978.383.camel@pmac.infradead.org>
Content-Type: text/plain
Date: Wed, 05 Dec 2007 00:54:38 +0000
Message-Id: <1196816078.13978.411.camel@pmac.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Tue, 2007-12-04 at 22:33 +0000, David Woodhouse wrote:
> Make vmlinux the default target instead of zImage would seem like a
> better answer. I'm surprised that it isn't like that already, in fact --
> and I'm only inferring that it isn't from your message. I always thought
> that if I typed 'make' I got the vmlinux and not a zImage.

Ooh, no -- I don't. I get an error, and I never even noticed...

  WRAP    arch/powerpc/boot/zImage.chrp
  WRAP    arch/powerpc/boot/zImage.pmac
  WRAP    arch/powerpc/boot/cuImage.52xx
/pmac/git/libertas-2.6/arch/powerpc/boot/wrapper: line 257: mkimage: command not found
make[1]: *** [arch/powerpc/boot/cuImage.52xx] Error 127


I'd be perfectly happy with 'make vmlinux then' as a response to anyone
who complains. And in fact since it'll correctly make the vmlinux and
_then_ fail to create the zImage, I would have thought that anyone with
even a modicum of common sense will _notice_ that, and start using 
'make vmlinux' all by themselves without prompting.

-- 
dwmw2
