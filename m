Message-Id: <9907221904.AA22476@marc.watson.ibm.com>
To: "Ringeman, Tim" <tim_ringeman@gilbarco.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: x86 --> powerpc/MBX Cross Compiler 
In-Reply-To: Message from "Ringeman, Tim" <tim_ringeman@gilbarco.com>
   of "Thu, 22 Jul 1999 14:46:32 EDT." <199907221847.OAA29580@hoover.gilbarco.com>
Date: Thu, 22 Jul 1999 15:04:39 -0400
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> "Ringeman, Tim" writes:

Tim> I was wondering if anyone has been able to get binaries for or build a C and
Tim> C++  x86 --> powerpc/MBX cross-compiler. I was able to get a C compiler a
Tim> while ago but now I need a C++ cross-compiler to be able to develop more
Tim> apps. Your help would be greatly appreciated.

	EGCS fully supports cross-builds.  You should be able to use the
same egcs-1.1.2 source, configure for powerpc/MBX with C and C++
languages, and use the "make cross" build target.  See the gcc cross FAQ.

David

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
