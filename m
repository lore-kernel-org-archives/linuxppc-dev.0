Message-Id: <9905111522.AA48044@marc.watson.ibm.com>
To: Joel Klecker <jk@espy.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: imac of booting 
In-Reply-To: Message from Joel Klecker <jk@espy.org>
   of "Tue, 11 May 1999 01:36:38 PDT." <v04204e08b35d9989574a@[206.163.71.146]>
Date: Tue, 11 May 1999 11:22:58 -0400
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> Joel Klecker writes:

Joel> At 19:59 -0400 1999-05-10, Ben Martz wrote:
>> Stupid question maybe but I can't find a definitive answer. Can I boot
>> linuxppc from OF on my iMac? Does the elf loader in OF work?

Joel> The ELF loader in OF does work (part of the Mac OS boot process uses 
Joel> it in fact), however it does not like Linux kernel ELF images.

Joel> Until someone figures out the problem and fixes it, the answer is no.

	CHRP does not want just an ELF image, but an ELF image with a CHRP
"note" section.  The note section describes where to load the image,
whether the image is running real or virtual, and how to instantiate OF.
NetBSD has more details about this for their macppc port.  Cort may
already have addressed some of this for the CHRP-based RS/6000 port work.

	CHRP looks for a PT_NOTE section in the loader header and then
specific magic values in the section itself.

David


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
