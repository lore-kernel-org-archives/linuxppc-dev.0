Date: Fri, 26 Feb 1999 00:09:59 -0700 (MST)
From: Cort Dougan <cort@persephone.cs.nmt.edu>
To: VALETTE Eric <valette@crf.canon.fr>
cc: jpeters@phx.mcd.mot.com, paubert@iram.es, jeremy@goop.org,
        linuxppc-dev@lists.linuxppc.org
Subject: bootloader problems and linux/ppc developers tree
In-Reply-To: <m10FDOf-0000WXC@tri-yann.crf.canon.fr>
Message-ID: <Pine.LNX.3.96.990225235440.16856C-100000@persephone.cs.nmt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I need everyone with their favorite bootloaders to talk to one another.  I
can't be the communication point between you all.  There are several
groups out there who have interest in certain boards to work - and
don't care about the others.  Unfortunately, this has given us a set of
bootloaders that work on subsets of the machines.

What I'd really appreciate is if you guys could give one another your
versions of the bootloaders and iron out the differences.  I _cannot_ test
all the systems out - I don't have the hardware.  I'd very much like to
handle this quickly by having the hardware by merging them myself and
trying them out but I don't have the resources.  I need you to help me
here.

We need to resolve this now.  Someone, it doesn't matter who, stick a
bootloader for arch/ppc/prepboot on the ftp server here.  My preference the
one from Garbriel since most people have based their work off of it.
That'll be our new reference bootloader.  Then, everyone with a board they
need to work grab it and test it out.  If it doesn't work, or doesn't work
the way you like send all of us that are interested email with your
problems and your code merged in to fix your problems (if you have any
code, otherwise we can try to fix the problems).

Then we can get this prepboot situation over with.  I want all boards
booting and I will not put in a new bootloader that breaks the older
boards.  Arguments about 'having to break things sometimes' have their
strengths, but I don't think this is the place or time.  2.2.x needs
to be stable and not just drop support for certain boards to begin
supporting newer ones.  I do not want to get into the habit of screwing
users with older boards (one of whom is me - I only have the older prep
boards).

Within the next few weeks if we can't get this settled I think it would
worth creating separate bootloaders for prep machines.  If the designs are
so different this may be the only way - but I'd like to give a real try to
find a general solution first.

Once that is finally retired I'd like to merge in the other changes that
have backed up (smp mtx and so on) so I can create a linux/ppc developer
tree.  I'll talk to Larry about bitkeeper this week to find out useful it
would be in this case.  If things don't look ready with bitkeeper I'll
create a cvs tree here.

Does this sound good to everyone?  I think this will address the more
immediate problems.  2.2.x is a good time to resolve these issues and I'd
like to do it right.  I'd hate to loose the good work you've all done
by things getting too divergent.  Lets share code and try to hammer out a
common bootloader for prep now.

I'll be at linuxworld so I may not be able to respond to email about the
bootloader as quickly as I'd like.  I'll probably be doing work there, too
but I need a lot of feedback from you to get this done.

}That's your choice. Provided you do not ask me to agree and do not
}ask for support of your way of handling patches...


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
