Date: Fri, 31 Jan 2003 23:55:11 +0100 (MET)
From: Andreas Plaickner <apxx@gmx.net>
To: Wolfgang Denk <wd@denx.de>
Cc: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Subject: Re: 3Com 574BT PCMCIA Card on PowerPC 
Message-ID: <26456.1044053711@www52.gmx.net>
Content-Type: text/plain; charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

thanks a lot for the answers and the suggestion to create
a new kernel.

On Fri, 31 Jan 2003, Wolfgang Denk wrote:

> > I have seen that there exists already a solution
> > for a wireless LAN card. I took these steps as
>
> Which one are you talking about? Where did you get the kernel sources
> and the PCMCIA CS package from?

I am working in a university, and there I got the sources.

> > I didn't create a new kernel, but I used one that was already
> > pre-installed on the board. Could this one be the reason
> > for the above error?
>
> Definitely. You will need a current kernel,  and  currend  PCMCIA  CS
> package.

The steps on how to build a RAM-Disk explained in a previous posting,
I think I have done right.

I have a question regarding the building of a new kernel. The eldk,
linux-2.4 kernel and pcmcia-cs-3.2.0.tgz tarball are needed.
They can be downloaded on www.denx.de.
For the kernel there are two modules available, according to
ftp://ftp.denx.de/pub/RTAI/24.1.10/README.install
the linux-2.4 is used. Is this ok, or should the linuxppc_2_4_devel
be used?

Then I think it is necessary to apply the latest patch, depending on the
module chosen.

In ftp://ftp.denx.de/pub/RTAI/24.1.10/README.install point 3 says,

3. Configure and make the RTAI patched Linux kernel:

   $ export CROSS_COMPILE=ppc_8xx-
   $ make TQM860L_config
....

I use a board of TTTech, with MPC855T processor. Do you have any
suggestions if this make is alright or I need to change, or let away?
.....
   $ make dep
   $ make pImage
   $ cp -p arch/ppc/mbxboot/pImage /tftpboot

Can this image already be used on the PowerPC. I tried once, but
it was not possible. Is it possible to compile RTAI somehow into the
kernel and to load this so created kernel onto the board? Or are
the next steps described in README.install also necessary?

Thanks a lot in advance for any suggestions.

Andreas


--
+++ GMX - Mail, Messaging & more  http://www.gmx.net +++
NEU: Mit GMX ins Internet. Rund um die Uhr für 1 ct/ Min. surfen!


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
