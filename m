Message-Id: <199905070519.BAA01244@borg.mit.edu>
To: Brad Boyer <flar@cegt201.bradley.edu>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Question about SMP 
Reply-To: locutus@MIT.EDU
In-Reply-To: Your message of "Thu, 06 May 1999 23:42:45 CDT."
             <199905070442.XAA11076@cegt201.bradley.edu>
Date: Fri, 07 May 1999 01:19:47 -0300
From: "Charles E. Leiserson, Jr." <locutus@MIT.EDU>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


What model PowerMac do you have?

I have a 2.2.7 kernel that runs very nicely on a PowerMac 7300/400MP.  It's been tried by several others on different machines, and it has worked.

You can find it at ftp://borg.mit.edu/pub/linux/ppc/kernels/multiprocessor/ along with its various support files (ie. System.map, modules, .config, etc.).  They're all gzipped and ready to use.  Don't forget to untar modules.tar.gz from / :)

If it works, you can compile your own from the .config file provided.  Good luck!


					- Ricky

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
