Message-ID: <XFMail.990407081744.gdt@linuxppc.org>
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
In-Reply-To: <B0002009499@icamail.ica.net>
Date: Wed, 07 Apr 1999 08:17:44 +0100 (BST)
From: Gary Thomas <gdt@linuxppc.org>
To: Trevor Woerner <twoerner@ica.net>
Subject: RE: [LinuxPPC] Gary Thomas' libc sources
Cc: Developer LinuxPPC <linuxppc-dev@lists.linuxppc.org>
Cc: Developer LinuxPPC <linuxppc-dev@lists.linuxppc.org>,
        Users LinuxPPC <linuxppc-user@lists.linuxppc.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



On 07-Apr-99 Trevor Woerner wrote:
> dear friends,
> 
> i was looking into compiling glibc for myself so i downloaded
> Gary Thomas' sources from ftp.linuxppc.com under the subdir
> /linuxppc/users/gdt/redhat/SRPMS/. i downloaded glibc-961212-1o.src.rpm.
> 
> once on my system i did a:
>  
>   root# rpm -i <...glibc-961212...>
> 
> and in my /usr/src/redhat/SOURCES directory (or something like that)
> i ended up with a whole pile of stuff that i'm not sure what to
> do with. i would appreciate some guidance.
> 
> i ended up with the following:
>    axp-extras-960810.tar.gz
>    libc-961117-ldd.patch
>    libc-961212-ewt.tar.gz
>    libc-fsstnd-4.diff.gz
>    libc-rev1i.patch
>    libc-rev1j.patch
>    libc-rev1k.patch
>    libc-rev1l.patch
>    libc-rev1m.patch
>    libc.works-ppc.patch
>    libc.zic.synlink.hack.diff.gz
>    nsswitch.conf
> 
> what the heck are all of these :-? so i unzipped and untarred the 
> libc-961212-ewt.tar.gz (since it seemed, out of this bunch to be
> the most obvious, even though i'm not sure what an "ewt" is...)
> and it created a libc.works directory (or something like that) which
> had thousands of files: 90% of which were zero-length!
> 
> could someone tell me what's going on? what do i need to compile libc?
> have the patches already been applied (if not now would i do that)?
> what is the "conf" file for? or the "symlink.hack" for? etc... etc...
> etc...
> 

To build an RPM from the SRPM file:

  # cd /usr/src/redhat/SPECS
  # rpm -i <SRPM-file>
  # rpm -ba <SPEC-file>    // You need to figure out this file name
                           // there is no standard and it will appear
                           // in this directory after the previous step.

That's it.  The last step (-ba) takes care of all of the unpacking, patching,
building, installing, ...

If you want to install this [potentially new] package "live" on your
system, just use the normal install runes:

  # rpm -ivUh ../RPMS/ppc/<RPM-file>  // Created by the -ba step

BTW - I've just uploaded version "1p" of the GLIBC package.  You should
work from that.

For more details, look at my tutorial:

  http://www.chez-thomas.demon.co.uk/RPMS/RPM_tutorial.html


------------------------------------------------------------------------
Gary Thomas                              |
email: gdt@linuxppc.org                  | "Fine wine is a necessity of
   ... opinions expressed here are mine  |        life for me"
       and no one else would claim them! |
                                         |      Thomas Jefferson
------------------------------------------------------------------------



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
