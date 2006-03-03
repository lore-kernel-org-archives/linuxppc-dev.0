Return-Path: <pnasrat@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by ozlabs.org (Postfix) with ESMTP id AA984679A6
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Mar 2006 10:46:00 +1100 (EST)
Subject: Re: [PATCH] force stackpointer alignment in 64bit kernel
From: Paul Nasrat <pnasrat@redhat.com>
To: Olaf Hering <olh@suse.de>
In-Reply-To: <20060303232334.GA9577@suse.de>
References: <20060303135717.GA5707@suse.de> <20060303165253.GA6494@suse.de>
	<20060303191633.GA7792@suse.de>
	<3E10742C-61F9-417C-A191-C0C8C46A4529@kernel.crashing.org>
	<20060303232334.GA9577@suse.de>
Content-Type: text/plain
Date: Fri, 03 Mar 2006 18:45:58 -0500
Message-Id: <1141429559.19461.13.camel@enki.eridu>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2006-03-04 at 00:23 +0100, Olaf Hering wrote:
>  On Fri, Mar 03, Segher Boessenkool wrote:
> 
> > > The stackpointer came from 32bit code, which appearently has different
> > > alignment rules than 64bit code. The chain was yaboot -> zImage ->  
> > > vmlinux
> > > Force the stackpointer to be 16 byte aligned.
> > 
> > The stack pointer is required to be 16-byte aligned when the
> > client program is started, on 32-bit as well.
> 
> See http://ozlabs.org/pipermail/linuxppc-dev/2006-March/021342.html
> 
> Either yaboot and/or zImage need to force a stack alignment, or we apply
> the 2 liner.

Happy to look at/receive patches for yaboot.  I'll look on Monday.

Paul
