Message-ID: <B0002009499@icamail.ica.net>
Subject: [LinuxPPC] Gary Thomas' libc sources
Date: Tue, 6 Apr 99 22:39:22 -0400
From: Trevor Woerner <twoerner@ica.net>
To: "Users LinuxPPC" <linuxppc-user@lists.linuxppc.org>,
        "Developer LinuxPPC" <linuxppc-dev@lists.linuxppc.org>,
        "Gary Thomas" <gdt@linuxppc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


dear friends,

i was looking into compiling glibc for myself so i downloaded
Gary Thomas' sources from ftp.linuxppc.com under the subdir
/linuxppc/users/gdt/redhat/SRPMS/. i downloaded glibc-961212-1o.src.rpm.

once on my system i did a:
 
  root# rpm -i <...glibc-961212...>

and in my /usr/src/redhat/SOURCES directory (or something like that)
i ended up with a whole pile of stuff that i'm not sure what to
do with. i would appreciate some guidance.

i ended up with the following:
   axp-extras-960810.tar.gz
   libc-961117-ldd.patch
   libc-961212-ewt.tar.gz
   libc-fsstnd-4.diff.gz
   libc-rev1i.patch
   libc-rev1j.patch
   libc-rev1k.patch
   libc-rev1l.patch
   libc-rev1m.patch
   libc.works-ppc.patch
   libc.zic.synlink.hack.diff.gz
   nsswitch.conf

what the heck are all of these :-? so i unzipped and untarred the 
libc-961212-ewt.tar.gz (since it seemed, out of this bunch to be
the most obvious, even though i'm not sure what an "ewt" is...)
and it created a libc.works directory (or something like that) which
had thousands of files: 90% of which were zero-length!

could someone tell me what's going on? what do i need to compile libc?
have the patches already been applied (if not now would i do that)?
what is the "conf" file for? or the "symlink.hack" for? etc... etc...
etc...

thank you and best regards,
   trevor woerner

------------------------------------------------------------

     Trust the computer industry to shorten "Year 2000"
     to "Y2K". It was this kind of thinking that caused
     the problem in the first place.
                                    -- Tony Poldrugovac


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
