Date: Fri, 15 Jan 1999 15:04:30 -0700 (MST)
From: Cort Dougan <cort@persephone.cs.nmt.edu>
To: Michael Meissner <meissner@cygnus.com>
cc: Alois Fertl <alois_fertl@mucmot.muenchen.europe.mcd.mot.com>,
        linux-kernel@vger.rutgers.edu, linuxppc-dev@lists.linuxppc.org,
        gdt@cygnus.com
Subject: Re: Booting 2.2.0-pre6 on a PowerStack-II (Net 4000/200)
In-Reply-To: <19990115165805.A28318@tiktok.cygnus.com>
Message-ID: <Pine.LNX.3.96.990115150135.11410A-100000@persephone.cs.nmt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


His gets it from the OF.  There's no OF code used in the prep bootloader
in the current kernels.

Are you netbooting or floppy booting?

}Also, Gary Thomas's 2.0.32 kernel seemed to have no problem in sizing memory,
}so I presume it is able to pick up the residual data.


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
