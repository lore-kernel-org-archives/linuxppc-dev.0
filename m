Date: Wed, 5 Jan 2000 11:19:30 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Brendan J Simon <Brendan.Simon@ctam.com.au>
cc: "Momchil 'Velco' Velikov" <velco@fadata.bg>,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Linux ABI documents and powerpc supplements.
In-Reply-To: <3872E2F7.B7FA2F22@ctam.com.au>
Message-ID: <Pine.LNX.4.10.10001051110270.31184-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > -shared is used to *create* a shared library. You need -Bdynamic in
> > order to force the executable to be linked against shared libraries.
> 
> I think you are confusing the ld arguments and the gcc arguments.  ld uses -Bdynamic and -Bstatic

I think you misread the documentation. It has always been my understanding
that -static explicitly prevents linking to shared libraries (which is
otherwise the default), wheras -shared prepares an object to be used as
part of a shared library later:

> `-shared'
>      Produce a shared object which can then be linked with other
>      objects to form an executable.  Not all systems support this
>      option.  You must also specify `-fpic' or `-fPIC' on some systems
>      when you specify this option.

That pretty much states it makes no sense using -shared in the final
linkage step for a binary.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
