Message-Id: <9907231730.AA38796@marc.watson.ibm.com>
To: Naushit Sakarvadia <nsakarvadia@telogy.com>
Cc: "'LinuxPPC Developpers'" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Cross Compilaton 
In-Reply-To: Message from Naushit Sakarvadia <nsakarvadia@telogy.com>
   of "Fri, 23 Jul 1999 12:02:53 EDT." <61891BA043DED21180920090273F173829B0D0@argentina.telogy.com>
Date: Fri, 23 Jul 1999 13:30:42 -0400
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


	You need to BUILD a cross-compiler version of GCC for the
particular target.  GCC does not know about EVERY architecture in a single
compiler executable.  Your x86 EGCS compiler only knows about x86 target.

David

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
