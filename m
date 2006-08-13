Return-Path: <acahalan@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.189])
	by ozlabs.org (Postfix) with ESMTP id 43A1967C55
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Aug 2006 04:59:03 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id k27so2326855nfc
	for <linuxppc-dev@ozlabs.org>; Sun, 13 Aug 2006 11:59:02 -0700 (PDT)
Message-ID: <787b0d920608131159m1e83fc9ax44a20f7fde2bb982@mail.gmail.com>
Date: Sun, 13 Aug 2006 14:59:01 -0400
From: "Albert Cahalan" <acahalan@gmail.com>
To: "Hollis Blanchard" <hollis@penguinppc.org>
Subject: Re: PowerPC paxtest results w/ gcc-4.1
In-Reply-To: <1155487501.18244.0.camel@diesel>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <787b0d920608112250q551c98f5j328183c31eebaf77@mail.gmail.com>
	<17629.48408.564322.747132@cargo.ozlabs.ibm.com>
	<787b0d920608120736n1ba0bc03jccf2964bf7ebb1d5@mail.gmail.com>
	<17630.27174.711916.643790@cargo.ozlabs.ibm.com>
	<787b0d920608121948rad24dc7le834f1b499543ace@mail.gmail.com>
	<17630.39716.551115.850057@cargo.ozlabs.ibm.com>
	<787b0d920608122111p79f29d74r600382658599cd63@mail.gmail.com>
	<1155487501.18244.0.camel@diesel>
Cc: linuxppc-dev@ozlabs.org, debian-powerpc <debian-powerpc@lists.debian.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 8/13/06, Hollis Blanchard <hollis@penguinppc.org> wrote:
> On Sun, 2006-08-13 at 00:11 -0400, Albert Cahalan wrote:
> >
> > On 8/12/06, Paul Mackerras <paulus@samba.org> wrote:
> > > Albert Cahalan writes:
> > >
> > > > VM_STACK_DEFAULT_FLAGS32 is wrong. A fail-safe
> > > > default is important for security. If gcc on PowerPC ever
> > > > does generate code which puts trampolines on the stack,
> > > > then that can be fixed by converting to legal C code or
> > > > by adding the fragile marking to the defective executables.
> > > > Did gcc ever generate such code on PowerPC? If not,
> > > > then there is no reason to ever allow an executable stack.
> > >
> > > I believe it did for nested procedures in C.
> >
> > I just disassembled libgcc. You're right. Eeeeeew.
> > I filed a bug describing two better methods for this.
>
> URL?

http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=382746
