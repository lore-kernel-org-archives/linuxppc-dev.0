Message-Id: <9907112303.AA25560@marc.watson.ibm.com>
To: "Charles A. Jolley" <charles.jolley@zeratec.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Netbooting Linux on an iMac 
In-Reply-To: Message from "Charles A. Jolley" <charles.jolley@zeratec.com>
   of "Sun, 11 Jul 1999 16:03:54 CDT." <199907112116.QAA23835@www2.tuckeris.com>
Date: Sun, 11 Jul 1999 19:03:17 -0400
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


	Please look in the archive of this mailinglist where you will find
a detailed answer from me about exactly what an OpenFirmware boot image
must look like to be recognized and loaded.  It basically is a 32-bit
PowerPC ELF image with a special NOTE section and the loader section in
the header referencing the NOTE section.

David

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
