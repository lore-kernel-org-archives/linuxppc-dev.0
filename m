Return-Path: <jonsmirl@gmail.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.25])
	by ozlabs.org (Postfix) with ESMTP id 0E3EADF6EC
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jul 2008 02:15:43 +1000 (EST)
Received: by qw-out-2122.google.com with SMTP id 9so227017qwb.15
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jul 2008 09:15:41 -0700 (PDT)
Message-ID: <9e4733910807150915n6993932dr780f00342fadb4e@mail.gmail.com>
Date: Tue, 15 Jul 2008 12:15:41 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Matt Sealey" <matt@genesi-usa.com>
Subject: Re: 2.6.26 does not boot on Pegasos
In-Reply-To: <487CC1F5.5090706@genesi-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080715100033.GA5147@iram.es> <487CC1F5.5090706@genesi-usa.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 7/15/08, Matt Sealey <matt@genesi-usa.com> wrote:
> If you built this kernel yourself, you need to do it from a system with
>  an up-to-date binutils (2.18) otherwise, it does this.
>
>  If you got it from somewhere (like a distribution) then please tell us
>  where, as there are some other troubles with load-base location for
>  Fedora and so on...

Is it hard to put a check into the kernel make system to look for
binutils 2.17 and refuse to build with a nice error message? I poked
around in the makefile but I'm not 100% sure of how it works.

>
>  --
>  Matt Sealey <matt@genesi-usa.com>
>  Genesi, Manager, Developer Relations
>
>
>  Gabriel Paubert wrote:
>
> >        Hi,
> >
> > I just tried to boot 2.6.26 on a Pegasos and the kernel does not boot.
> > The last message I have is:
> > gunzip (0xffffffff <----- some more hex digits)
> >
> > The configuration has been created from a working 2.6.25 one with
> > make oldconfig and answering N to new config options.
> >
> > Anybody has seen this or do I have to start digging deeper?
> >
> >        Regards,
> >        Gabriel
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-dev
> >
>  _______________________________________________
>  Linuxppc-dev mailing list
>  Linuxppc-dev@ozlabs.org
>  https://ozlabs.org/mailman/listinfo/linuxppc-dev
>


-- 
Jon Smirl
jonsmirl@gmail.com
