Date: Wed, 7 Apr 1999 13:46:32 -0500 (CDT)
From: Dave Weis <djweis@plconline.com>
To: David De Ridder <david.de.ridder@bitsmart.com>
cc: LinuxPPC Developers List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: MVME2306 progress
In-Reply-To: <Pine.SO4.4.05.9904071129260.15656-100000@hsins.uia.ac.be>
Message-ID: <Pine.LNX.3.95.990407134414.19623G-100000@catbert.desm.plconline.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




> * rpm works fine on the NFS host (a Linux/i386 PC), but not on the
>   board itself. I suspect it has to do with the path settings.
>   On the PC, I use ``--root /export'' for the correct path. On the
>   board however, I get always this message :
>   
>   ``failed to open //var/lib/rpm/packages.rpm''
> 
>   Note the double-slash. Using ``--root /'' on the board did not work.

It's not the path settings - I get the same thing if I try to use rpm as a
non-root user.

[djweis@webdevel djweis]$ rpm --install BitchX-75p3-4.i386.rpm 
failed to open //var/lib/rpm/packages.rpm

error: cannot open //var/lib/rpm/packages.rpm

Check your nfs exports, make sure no_root_squash it turned on for the
exported filesystem. Otherwise your root user is basically nobody.


djweis

-- 
David Weis                | 10520 New York Ave, Des Moines, IA 50322
djweis@plconline.com      | Voice 515-278-0133 Ext 231
http://www.plconline.com/ | "Great spirits will always encounter violent
                          | opposition from mediocre minds" - Einstein


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
