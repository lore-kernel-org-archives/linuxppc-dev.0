Date: Fri, 26 Feb 1999 12:05:09 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
Reply-To: Gabriel Paubert <paubert@iram.es>
To: Cort Dougan <cort@persephone.cs.nmt.edu>
cc: VALETTE Eric <valette@crf.canon.fr>, jpeters@phx.mcd.mot.com,
        jeremy@goop.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: bootloader problems and linux/ppc developers tree
In-Reply-To: <Pine.LNX.3.96.990225235440.16856C-100000@persephone.cs.nmt.edu>
Message-ID: <Pine.HPP.3.96.990226113200.3871X-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Fri, 26 Feb 1999, Cort Dougan wrote:

> I need everyone with their favorite bootloaders to talk to one another.  I
> can't be the communication point between you all.  There are several
> groups out there who have interest in certain boards to work - and
> don't care about the others.  Unfortunately, this has given us a set of
> bootloaders that work on subsets of the machines.

Indeed.

> What I'd really appreciate is if you guys could give one another your
> versions of the bootloaders and iron out the differences.  I _cannot_ test
> all the systems out - I don't have the hardware.  I'd very much like to
> handle this quickly by having the hardware by merging them myself and
> trying them out but I don't have the resources.  I need you to help me
> here.

Fine. 

> We need to resolve this now.  Someone, it doesn't matter who, stick a
> bootloader for arch/ppc/prepboot on the ftp server here.  My preference the
> one from Garbriel since most people have based their work off of it.
> That'll be our new reference bootloader.  Then, everyone with a board they
> need to work grab it and test it out.  If it doesn't work, or doesn't work
> the way you like send all of us that are interested email with your
> problems and your code merged in to fix your problems (if you have any
> code, otherwise we can try to fix the problems).

Ok, my bootloader still relies too much on residual data. I'm sorry for
this but I thought they would be reliable on recent boards, they are not 
and are often completely wrong, and old boards never provide them on
netboots. However, for interested people, I have put a program on my 
site (which I'll upload as soon as I can) in:

	ftp://vcorr1.iram.es/pub/other/residual.c.gz

which can be used to dump the contents of the residual data once you've
been able to upload them to a tftp server with a NIOP command under
PPCBug (note that the program will only run under a Linux/PPC machine,
I was to lazy to make it endian-independant and, horror, it includes
kernel headers for things like ld_le{16,32}).

> Then we can get this prepboot situation over with.  I want all boards
> booting and I will not put in a new bootloader that breaks the older
> boards.  Arguments about 'having to break things sometimes' have their
> strengths, but I don't think this is the place or time.  2.2.x needs
> to be stable and not just drop support for certain boards to begin
> supporting newer ones.  I do not want to get into the habit of screwing
> users with older boards (one of whom is me - I only have the older prep
> boards).

I only have MVME2600. 

> Within the next few weeks if we can't get this settled I think it would
> worth creating separate bootloaders for prep machines.  If the designs are
> so different this may be the only way - but I'd like to give a real try to
> find a general solution first.

I agree.

> Once that is finally retired I'd like to merge in the other changes that
> have backed up (smp mtx and so on) so I can create a linux/ppc developer
> tree.  I'll talk to Larry about bitkeeper this week to find out useful it
> would be in this case.  If things don't look ready with bitkeeper I'll
> create a cvs tree here.

Ok, note that it seems that anon cvs vger access has been removed forever
because the loadd as too high. I've been bitten very hard by this, and
will never go back to any cvs server which is not maintained by the
Linux/PPC people.

> Does this sound good to everyone?  I think this will address the more
> immediate problems.  2.2.x is a good time to resolve these issues and I'd
> like to do it right.  I'd hate to loose the good work you've all done
> by things getting too divergent.  Lets share code and try to hammer out a
> common bootloader for prep now.

Ok, of course if someone has a better base to start than my prepboot code,
he's welcome. 

	Gabriel.


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
