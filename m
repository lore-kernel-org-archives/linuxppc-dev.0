Message-Id: <9908131500.AA35672@marc.watson.ibm.com>
To: "Christopher A. Shepherd" <cshepher@hardrock.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: OF netbooting 
In-Reply-To: Message from "Christopher A. Shepherd" <cshepher@hardrock.com>
   of "Fri, 13 Aug 1999 09:56:56 EDT." <199908131356.JAA08439@ns.hardrock.com>
Date: Fri, 13 Aug 1999 11:00:03 -0400
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> "Christopher A Shepherd" writes:

Christopher> I built a special kernel by just assembling this and linking it into
Christopher> the kernel. Won't be able to test it until I get back home though. Could it
Christopher> really be this simple?

	Mostly.  See my earlier notes giving the full details about
exactly what OF expects.  The .note section needs to be referenced by a
PT_NOTE in the program header pointing to the note segment.

David

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
