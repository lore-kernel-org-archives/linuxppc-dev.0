Message-ID: <3766CF12.62875FF2@msoe.edu>
Date: Tue, 15 Jun 1999 17:09:22 -0500
From: ian geiser <geiseri@msoe.edu>
MIME-Version: 1.0
To: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>,
        "linuxppc-user@lists.linuxppc.org" <linuxppc-user@lists.linuxppc.org>
Subject: SCSI Help NEEDED!
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I am having a problem on my power center 132.
I have the stock SCSI system in place but when ever i try to use
my CD-R or scanner the bugger locks up tight!.

Last night i finnally found out why.  For some reason when i access
the scanner or cdr ALL information on the SCSI bus stops.  I have seen
this before on the i86 side and this is because something on the bus
will not support SCSI disconnect/reconnect.

Dose anyone know how to get arround this and how to fix it?
Dose anyone know how to set these options.  I know how to do it on
an adaptec card but i have no clue how to do it in the 2.2.x kernels....

    -ian reinhart geiser


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
