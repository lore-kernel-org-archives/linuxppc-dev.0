From: "Ira K. Weiny" <iweiny@kdat.csc.calpoly.edu>
Message-Id: <199908061807.LAA11714@kdat.csc.calpoly.edu>
Subject: Kernal crashes 
To: linuxppc-dev@lists.linuxppc.org
Date: Fri, 6 Aug 1999 11:07:42 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have used 2.1.24 kernal with a MkLinux/LinuxPPC mixture
system.  It's a long story but it worked.

I have just upgraded to R5 of the LinuxPPC distribution
(linuxppc.com) which has the 2.2.6 kernal.

I used my same scripts to connect with ppp to my ISP.  But the new pppd and
chat programs.

I have now expierenced serveral kernal crashes when running Netscape, and
once with rlogin.  The last of which destroyed my file system and now I
can't even log in.  Very disapointing.  I have emailed the linuxppc-user
list concerning this issue and apparently others have the same problem but
no one knows how to fix it.

I know the kernal goes down because I can not even telnet to the box.  Well
maybe telnetd just went down, but I can't even get a getty to shut the
machine down and that is why the file system is hosed.

Is there something different between the kernals concering serial support?
And if so what can I do about it?

I sent something to the linuxppc-user list but the only response I got back
was "I just don't use Netscape"  Well the problem happened with rlogin and I
don't see any reason Netscape (a user program) could mess up the kernal.  If
just Netscape were crashing that would be a different issue.

Can anybody help me with this.

Thanks
Ira Weiny
iweiny@acm.org


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
