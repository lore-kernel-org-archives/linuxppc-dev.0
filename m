Date: Mon, 12 Apr 1999 14:41:31 -0400 (EDT)
From: Alexander Derbes <acd@po.cwru.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: Crashing My PowerbookG3-Series when writing to the serial port
In-Reply-To: <199904120448.OAA20256@tango.anu.edu.au>
Message-ID: <Pine.LNX.4.04.9904121430510.15400-100000@discordia.student.cwru.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



I think I have found a bug, However, I am not sure how to go about
isolating it.  

I have written a little piece of C code which opens the serial port,
configures it to 8bits No Parity and 2 Stop bits at 9600 Baud, and then
write a few bytes and closes the serial port.  The code is being used to
send packets to an external device.

The code will sometimes hang the powerbook.  It seems that hangs occur
only directly after I have started apache.  The serial program is called
as a CGI by apache so that packets can be written to the device via the
web.

Because the machine is totally hung when the problem shows up I do not
know how to go about debugging it.  Any ideas?

-acd


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
