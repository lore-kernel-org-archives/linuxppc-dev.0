Message-ID: <38D87FC0.548D1E61@email.sps.mot.com>
Date: Wed, 22 Mar 2000 09:09:36 +0100
From: "Stephan Ruettiger (r0337c)" <r0337c@email.sps.mot.com>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
CC: Don Holmgren <djholm@fnal.gov>,
        linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: root nfs boot problems
References: <200003211928.UAA20238@denx.local.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The tcpdump during the boot sequence shows me the error. I see at the
host the packets during tftp download of the zImage file. As the NFS
client try to connect i see nothing. So i changed the default setting
for ethernet from SCC2 to SCC1 (as described in the manual for the board
:-) and it
works.

Wolfgang Denk wrote:
>
> In message <Pine.SGI.3.95.1000321111628.2421C-100000@hppc.fnal.gov> you wrote:
> >
> > I don't believe the "neighbour table overflow" errors are the problem.  I
> > get them frequently but otherwise have success.
>
> I have never seen such errors when the ethernet  inrface  is  working
> correclty.
>
> > It looks like a problem on your nfs server.  The "unable to get nfsd port
> > number from server" and "unable to get mountd port number from server"
> > messages indicate that at minimum, the portmapper is not running on your
> > server.  Perhaps mountd and/or nfsd are also not running.
>
> Well, IMHO it's more likely that no packets were  ever  sent  to  the
> ethernet  at  all.  This  type  of problemppens for instance when the
> Transmit Enable signal is not asserted.
>
> It might be useful to check with a sniffer if the box is transmitting
> at all...

Thanks,

     Stephan Ruettiger

------------------------
Stephan Ruettiger
Motorola Munich
r0337c@email.sps.mot.com
------------------------

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
