Message-ID: <3CA9C33F.9010007@pacbell.net>
Date: Tue, 02 Apr 2002 14:42:07 +0000
From: Armin <akuster@pacbell.net>
MIME-Version: 1.0
To: Dan Malek <dan@embeddededge.com>
Cc: paulus@samba.org, linux-galileo@source.mvista.com,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: EV-64260-BP & GT64260 bi_recs
References: <0203210213.AA15856@ivan.Harhan.ORG> <3C99801A.8070002@embeddededge.com> <15526.51621.991410.781713@argo.ozlabs.ibm.com> <3CA8A96D.9040309@embeddededge.com> <15529.17031.622986.926261@argo.ozlabs.ibm.com> <3CA9EA93.5000404@embeddededge.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dan Malek wrote:
>
> If you are using the 4xx stuff as an example, I don't really like the
> way that is being done, but I'm severely outnumbered in that battle so
> I had to retreat and work somewhere else (like MIPS :-).  I still
> prefer to wait and see how unmanagable it gets before we start reworking
> everything.  Again, I don't see how using a bootloader to provide
> information and adding more software complexity to drivers solves this
> problem.  If you can't make it work with #define constants and #ifdef
> code sections, how will changing a #define with a variable name and
> an #ifdef with an if () {} make it eaiser?

What battle would that be?? you're copied on all my changes to 4xx and
if you have a problem with it , you should say so:)

>
>> I have this dream that one day we will get to the point where adding
>> support for a new board only involves adding files to the kernel
>> tree, with no changes to existing files needed.
>

4xx you need 1 config , board.c, board.h and add board.h to ibm4xx.h at
a minimum.  The 4xx drivers when conversion to ocp is completed will
make it possible:) Think of ocp as a static or manual pci driver

>
>     -- Dan
>
>
>
>

armin


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
