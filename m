Message-Id: <9903281815.AA52914@marc.watson.ibm.com>
To: Trevor Woerner <twoerner@ica.net>
Cc: "Users LinuxPPC" <linuxppc-user@lists.linuxppc.org>,
        "Developer LinuxPPC" <linuxppc-dev@lists.linuxppc.org>,
        "Fred Fish" <fnf@cygnus.com>
Subject: Re: [LinuxPPC] cross compiler, compiling 
In-Reply-To: Message from Trevor Woerner <twoerner@ica.net>
   of "Sun, 28 Mar 1999 13:03:44 -0400." <B0001827320@icamail.ica.net>
Date: Sun, 28 Mar 1999 13:15:19 -0500
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


	Did you combine egcs, binutils, and newlib directories together?
You should not use newlib if you are intending to create a LinuxPPC
cross-compiler.  You need to point the configuration at the LinuxPPC
headers and libraries.

David

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
