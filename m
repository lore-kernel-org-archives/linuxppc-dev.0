Date: Fri, 12 Mar 1999 07:50:03 -0500
Message-Id: <199903121250.HAA18674@pc1.fred.org>
From: "F. Heitkamp" <fheitka@ibm.net>
To: Franz.Sirl-kernel@lauterbach.com
CC: fheitka@ibm.net, linuxppc-dev@lists.linuxppc.org, hjl@varesearch.com
In-reply-to: <4.2.0.25.19990311162952.03ed2b80@mail.lauterbach.com> (message
	from Franz Sirl on Thu, 11 Mar 1999 16:37:18 +0100)
Subject: Re: binutils-2.9.1.0.22b
References: <4.2.0.25.19990311162952.03ed2b80@mail.lauterbach.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


   X-Sender: fsirl-kernel@mail.lauterbach.com
   Date: Thu, 11 Mar 1999 16:37:18 +0100
   From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
   Cc: linuxppc-dev@lists.linuxppc.org,hjl@varesearch.com (H.J. Lu)
   Content-Type: text/plain; charset="us-ascii"; format=flowed

   Hmm, are you sure you did everything right during configure/make? I have no 
   problems with 22b on glibc-2.1 (R5) here. Just the usual ld testsuite FAILs:

I've been using all the latest tools I can find (the usuall gettext,
autoconf, automake etc.  I also am using glibc-2.1.  I would like to 
recompile it though, since the texinfo I had at the time was broken.
I do get a problem in the math library that I sort of ignored.  The 
system has been running mostly fine in spite of that error.  I did not
add any special options to configure, other than a --prefix=<dir>.

I'll going to replace my kernel header files and try again.  There may
be a problem there.  I'll let you know what happens.

Any tips are greatly appreciated.

Fred

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
