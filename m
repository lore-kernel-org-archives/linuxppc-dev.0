Date: Fri, 15 Jan 1999 13:10:04 -0700 (MST)
From: Cort Dougan <cort@persephone.cs.nmt.edu>
To: Alois Fertl <alois_fertl@mucmot.muenchen.europe.mcd.mot.com>
cc: Michael Meissner <meissner@cygnus.com>, linux-kernel@vger.rutgers.edu,
        linuxppc-dev@lists.linuxppc.org, gdt@cygnus.com
Subject: Re: Booting 2.2.0-pre6 on a PowerStack-II (Net 4000/200)
In-Reply-To: <369F5EB6.E34F17E8@mucmot.muenchen.europe.mcd.mot.com>
Message-ID: <Pine.LNX.3.96.990115130921.10558B-100000@persephone.cs.nmt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


It should find the pci devices.  It doesn't use residual data, it uses the
hard code table for interrupt routing.


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
