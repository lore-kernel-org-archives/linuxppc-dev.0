Message-ID: <3A382876.527B4FCF@serialsystem.com.sg>
Date: Thu, 14 Dec 2000 09:55:03 +0800
From: "jari.nguyen" <jari.nguyen@serialsystem.com.sg>
Reply-To: jari.nguyen@serialsystem.com.sg
MIME-Version: 1.0
To: Graham Stoney <greyham@research.canon.com.au>
CC: Nils Hagge <Nils.Hagge@stud.uni-hannover.de>,
        linuxppc-embedded@lists.linuxppc.org
Subject: Re: Kernel panic: No init found.
References: <006c01c0650f$73b65d60$1e894b82@pc30> <976717249.3a3785c2030de@mail.serialsystem.com.sg> <009201c06519$e83418d0$1e894b82@pc30> <20001214110328.A8430@brixi.research.canon.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

Graham Stoney wrote:

> That link from /opt/hardhat/devkit/ppc/8xx/powerpc-hardhat-linux to / on the
> target is usually the obscure problem when using the stuff from MV.  Dunno
> what they were thinking...

I know that this link is used for the application to look for library when it
run.
When you build an application the linker use the directory:

/opt/devkit/hardhat/ppc/8xx/powerpc-hardhat-linux/lib

so that, when the application runs, it'll look for the lib in that directory,
this is the reason
they need the link.

And below is my problem, does anyone try to place the libary on different
directories?
for example, I need to put the limit share library on the rom, the other I'll put
it in another
directory in the harddisk. I think that I have to point out the library
directory,
this problem here is I want to use current applications, I don't want to rebuild
all of these.
does anyone know how to do it, or where can I have the information about it?

Thanks in advance,
Jari


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
