From: LinuxPPC-Dev@associate.com
Date: 10 Apr 1999 14:53:03 -0000
Message-ID: <19990410145303.1090.qmail@associate.com>
To: linuxppc-dev@lists.linuxppc.org
cc: root@associate.com
Subject: Lock-up while building mod_perl
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

Yesterday while trying to build/compile the mod_perl RPM from
ftp://rawhide.redhat.com/SRPMS/SRPMS/mod_perl-1.18-5.src.rpm
I experienced a total lock-up/freeze/crash.  It's been a LONG while
since anything like that happened, so I thought I'd pass the new on here.
I have a suspicion that this may be connected to the glibc-p release,
which I recently upgraded to - this glibc also caused MySQL to stop working,
even when compiled against the new glibc.

Has anyone else seen this kind of problem (compiling mod_perl)?

I'm running on a 7200/90 updated with all the latest R4 stuff.

glen_stewart@associate.com

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
