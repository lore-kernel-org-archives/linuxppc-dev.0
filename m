Message-ID: <39F5BC45.1E19E7E5@mvista.com>
Date: Tue, 24 Oct 2000 09:43:49 -0700
From: Matthew Locke <mlocke@mvista.com>
MIME-Version: 1.0
To: Ralph Blach <rcblach@raleigh.ibm.com>
CC: "'linuxppc-embedded@lists.linuxppc.org'"
 <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: pointers to ld.so.1
References: <67505026E29DD311A9AA00508B7315F350A56D@EXCHANGE> <39F5B85C.2B6ED9DB@raleigh.ibm.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Ralph Blach wrote:
>
> I am working the Monta Vista port of linux to the IBM405gp
> and I am trying to put in a ramdisk.  What links do i need in a ramdisk
> so that
> the libraries can be found.  Right now, I get the message
>
> initKernel panic: Attempted to kill init!
> : error in loading shared libraries: libdl.so.2:Rebooting in 180
> seconds.. cannot open shared object file: No such file or directory
>
> Yet libdl.so.2 and all the links are the the /lib directory.
>

you are probably missing the link on the target

/opt/hardhat/devkit/ppc/4xx/powerpc-hardhat-linux -> /

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
