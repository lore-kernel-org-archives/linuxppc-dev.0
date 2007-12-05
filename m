Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D3E99DDFB0
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Dec 2007 12:51:41 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id lB51pc0j030301
	for <linuxppc-dev@ozlabs.org>; Tue, 4 Dec 2007 20:51:38 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lB51pbqD458394
	for <linuxppc-dev@ozlabs.org>; Tue, 4 Dec 2007 20:51:37 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lB51pbjJ028916
	for <linuxppc-dev@ozlabs.org>; Tue, 4 Dec 2007 20:51:37 -0500
Date: Tue, 4 Dec 2007 19:49:07 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: Merge dtc
Message-ID: <20071204194907.5c88f347@zod.rchland.ibm.com>
In-Reply-To: <1196816078.13978.411.camel@pmac.infradead.org>
References: <20071016050217.GA9052@localhost.localdomain>
	<1196733544.13978.201.camel@pmac.infradead.org>
	<18261.53985.700234.923526@cargo.ozlabs.ibm.com>
	<1196807633.13978.383.camel@pmac.infradead.org>
	<1196816078.13978.411.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 05 Dec 2007 00:54:38 +0000
David Woodhouse <dwmw2@infradead.org> wrote:

> 
> On Tue, 2007-12-04 at 22:33 +0000, David Woodhouse wrote:
> > Make vmlinux the default target instead of zImage would seem like a
> > better answer. I'm surprised that it isn't like that already, in fact --
> > and I'm only inferring that it isn't from your message. I always thought
> > that if I typed 'make' I got the vmlinux and not a zImage.
> 
> Ooh, no -- I don't. I get an error, and I never even noticed...
> 
>   WRAP    arch/powerpc/boot/zImage.chrp
>   WRAP    arch/powerpc/boot/zImage.pmac
>   WRAP    arch/powerpc/boot/cuImage.52xx
> /pmac/git/libertas-2.6/arch/powerpc/boot/wrapper: line 257: mkimage: command not found
> make[1]: *** [arch/powerpc/boot/cuImage.52xx] Error 127
> 
> 
> I'd be perfectly happy with 'make vmlinux then' as a response to anyone
> who complains. And in fact since it'll correctly make the vmlinux and
> _then_ fail to create the zImage, I would have thought that anyone with
> even a modicum of common sense will _notice_ that, and start using 
> 'make vmlinux' all by themselves without prompting.

People build what the default is.  You don't boot a vmlinux, you boot a
zImage (in most cases).

(Nevermind the fact that for the 'build patch on all arches' part Paul
mentioned earlier it doesn't really matter since they probably aren't
going to actually boot it anyway.)

josh 
