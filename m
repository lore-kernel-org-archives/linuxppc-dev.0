Date: Sat, 16 Jan 1999 10:02:49 -0600 (CST)
From: puetzk6715@uni.edu
Subject: Re: kernel 2.2.0-pre4
In-reply-to: <199901152332.RAA07320@www.cedarnet.org>
To: Kevin Puetz <kp11901@cedarnet.ORG>
Cc: linuxPPC-dev@lists.linuxppc.org
Message-id: <Pine.PMDF.3.96.990116095844.538987978A-100000@uni.edu>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I futzed around with this some more this morning. It haoppens also in a
pre6 I built off the rsynced code (samba).

Adding an argument of my own (such as a runlevel) seems to fix it (ie, I
can boot

linux: 2.2.0

will die on Copying OF device tre... done. (And it is dead).

linux: 2.2.0 5
will boot up.

I can try BootXing if anyone wants, but I'd like to keep my OF-boot
working?!

On Fri, 15 Jan 1999, Kevin Puetz wrote:

> 
> This happened to me too, though only when using a quik name for it (as 
> opposed to typing the full path/command. I'm going to try some more to debug
> this, but...
> 
> Typing this same command at the quik prompt did not have the problem. Any
> ideas? G3/233 DT (rev 1), quik 1.3.1,
> 
> My command is
> 
> image=/boot/vmlinux_010799
>     label=benh
>     root=/dev/hda7
>     append=" video=atyfb:vmode:17,cmode:16"
> 
> --
> +--------------------------------------------------------------------+
> |            .-'''''-.       Kevin Puetz                             |
> |          .'   _/|   `.                                             |
> |         :   =/_/      :    kp11901@cedarnet.org -preferred         |
> |        :   _/ |        :   Kevin.Puetz@039-server.pls.uni.edu      |
> |       (\  /  ,|        :   webmaster@039-server.pls.uni.edu        |
> |        \\/^\/||__     :                                            |
> |     _/~`~`""~`"` \_ .'  "Could you please continue the petty       |
> |  __/  -'/  `-._ `\_\__   bickering?  I find it - most intriguing." |
> |/     /-'`  `\   \  \-.\    --Data, STTNG, "Haven"                  |
> +--------------------------------------------------------------------+
> 
> ----------
> >From: fritzwe.linux@tamedia.ch
> >To: linuxppc-user@lists.linuxppc.ORG
> >Subject: kernel 2.2.0-pre4
> >Date: Fri, Jan 15, 1999, 3:29 AM
> >
> > Hi,
> >
> > I'm trying this kernel I've found at http://calvaweb.calvacom.fr/bh40
> > because of the support for my AHA2940UW and the 3-button mouse I've
> > missed so badly in 2.1.25.
> >
> > The line "Welcome to Linux, kernel 2.2.0-pre4 booting..." appears and
> > that's it.
> >
> > I've put vmlinux into the System Folder.
> >
> > BootX 1.0.1 is configured as follows:
> >   boot device: sdc4 (thats the UW-scsi drive where the System
> >                      Folder is located)
> >   More kernel arguments: root=/dev/sda4 swap=/dev/sda5 vmode=14 cmode=8
> >                          (/dev/sda is attached to the internal scsi).
> >
> > The Mac is a 7200/90


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
