Date: Wed, 9 Dec 1998 02:05:52 -0700 (MST)
From: Cort Dougan <cort@persephone.cs.nmt.edu>
To: Matt Porter <mmporter@home.com>
cc: Alois Fertl <alois_fertl@muenchen.europe.mcd.mot.com>,
        VALETTE Eric <valette@crf.canon.fr>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Linux-2.1.129 boot on MCP750
In-Reply-To: <Pine.LNX.3.96.981123134306.1805A-100000@liberty.chnd1.az.home.com>
Message-ID: <Pine.LNX.3.96.981209020440.14818A-100000@persephone.cs.nmt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


You can change the address that ppcbug loads the image to.  I pointed mine
at the end of memory to keep it out of the way.  The boot code for prep is
very delicate right now due to the many many addresses that boards load
the image at so anything that can make it easier (such as moving the
address the kernel is loaded at) I want to take advantage of.

}> There is a problem in boot/misc.c which manifests only
}> if netboot is used. Current ppcbug netboots at 0x5000 and
}> this forces decompress to overwrite its own source.
}
}Can you elaborate on which versions of ppcbug this is a problem with and
}in what cases?  I have been booting the kernel on MVME23/26/27/36xx and an
}MCP750 without seeing this problem...maybe cause my MCP750 has an older
}rev of ppcbug.

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
