Date: Tue, 27 Jul 1999 12:32:39 -0700 (PDT)
Message-Id: <199907271932.MAA28492@saul4.u.washington.edu>
From: a sun <asun@saul4.u.washington.edu>
To: jhart@abacus.bates.edu
CC: MBoie@Adobe.COM, rspell@bates.edu, linuxppc-dev@lists.linuxppc.org,
        netatalk-admins@umich.edu
In-reply-to: <199907271901.PAA22932@abacus.bates.edu> (jhart@abacus.bates.edu)
Subject: Re: Netatalk  bug?, too many routes/iface
References: <199907271901.PAA22932@abacus.bates.edu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


   I presume, then, that this is a bug in the Appletalk code in LinuxPPC, 
   even though it's numbered 0.18, as compared to 0.17 in the Redhat 5.2 
   we're running on our Intel machines.  The Intel machines have no problem 
   with our network numbering ranges, which, according to our network 
   administrator, can legally go from 1 to 65535.

i think that it might have been an endianness bug, but i'm not
sure. if it still happens with linux-2.2.10, let me know, and i'll
look into it. oh yeah, your administrator is wrong about the range of
possible network numbers. numbers from 65280 to 65534 are reserved for
routerless networks.

-a



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
