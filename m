Date: Thu, 8 Jul 1999 13:10:36 -0500 (CDT)
From: Joseph Palani Garcia <jpgarcia@execpc.com>
To: Peter Handel <phandel@cise.ufl.edu>
cc: linuxppc-user@lists.linuxppc.org,
        LinuxPPC-Dev Liste <linuxppc-dev@lists.linuxppc.org>,
        Linux/Powermac <linux-pmac@samba.anu.edu.au>
Subject: Re: linux-pmac 2.2.10: media bay panics on PBG3
In-Reply-To: <Pine.GSO.4.05.9907081145280.1822-100000@eclipse.cise.ufl.edu>
Message-ID: <Pine.GSO.3.95.990708130406.2237A-100000@earth>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 8 Jul 1999, Peter Handel wrote:

> 
> Looks like it's time to bust out "diff" ... You could write a quick
> /bin/sh script that does something like:
> 
> for DFILE in `find /usr/src/linux-1 -name \* -print`; do
>   diff $DFILE /usr/src/linux-2/$DFILE # > $DFILE.diff
> done
> 
> (uncomment the > $DFILE.diff if you want the diffs in a file instead
> of to stdout)
> 
> ...although I bet they're just different ac releases of 2.2.10.
>

Even easier, use diff -r for recursive.  to get the kind of output we are
used to in rcs and general patch files, use the -u switch also.

so to compare 2 kernels or dirs in general, use
diff -ru dir.orij dir.new > dir.patch

and if you feel the need to ever apply these changes to another similar
directory (like your personal changes to a 2.2.10 and try to apply to a
2.2.11) ,just change to that kernel's dir, and type patch -p1 < dir.patch
and it will apply it as best it can. 

--

Joseph Garcia
Madison, WI
jpgarcia@execpc.com


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
