Return-Path: <zseries9@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.173])
	by ozlabs.org (Postfix) with ESMTP id 0E2A2DDECD
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 17:41:12 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id c2so138357ugf
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 00:41:10 -0700 (PDT)
Message-ID: <feaf5ed90705300034o7256f7e5o8e48d19502fa5c45@mail.gmail.com>
Date: Wed, 30 May 2007 16:34:31 +0900
From: "Hiroyuki Machida" <Hiroyuki.Mach@gmail.com>
Sender: zseries9@gmail.com
To: "Steve Munroe" <sjmunroe@us.ibm.com>
Subject: Re: Saving to 32 bits of GPRs in signal context
In-Reply-To: <OFB4FD81AE.95147932-ON862572EA.007EAB56-862572EA.007FDB77@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <1180475055.19517.206.camel@localhost.localdomain>
	<OFB4FD81AE.95147932-ON862572EA.007EAB56-862572EA.007FDB77@us.ibm.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Reply-To: Hiroyuki.Mach@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Steve,

2007/5/30, Steve Munroe <sjmunroe@us.ibm.com>:
>
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote on 05/29/2007
> 04:44:15 PM:
  :
  :
> > >
> > > Also if you want to debug this code (see long long variables correctly
> from
> > > GDB or even see the upper 32-bits of GPRs) you will need an ABI change
> so
> > > that GDB/DWARF knows what to do.

As already mentioned, ABI (calling convetion and relocations) wont't change,
so there's no exteion to DWARF required,  I think. Do you have any concern ?

> >
> > I personally don't care about gdb seeing those or anything like that,
> > those would be strictly local asm optimisations, at least that's my
> > point of view on the matter.
> >
> Well others do. If gcc supports code gen for this they will expect GDB
> support.

Even now,  gcc -m32 -mpowerpc64  produces 64 bit insns.
I've cheked with gcc version 4.1.1 20070105 (Red Hat 4.1.1-51).
But in most case, developers would use these options to some
specific files which are critical to performance.

I think GDB support is not critical, but would be expected.

---
Hiroyuki Machida
