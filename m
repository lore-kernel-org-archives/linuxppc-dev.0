Date: Thu, 7 Jan 1999 14:17:22 -0700 (MST)
From: Cort Dougan <cort@persephone.cs.nmt.edu>
To: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
cc: Brad Midgley <brad@pht.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: system.h and "::"
In-Reply-To: <Pine.LNX.4.03.9901071829510.16860-100000@mercator.cs.kuleuven.ac.be>
Message-ID: <Pine.LNX.3.96.990107141703.4626A-100000@persephone.cs.nmt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I just undid that and sent patches to Linus.  I'll put back the fix and
resubmit it to Linus.

}> has special meaning to the c++ compiler. the compile succeeds if it's
}> broken up into ": :" but will that cause any problems? does that have the
}> same meaning in assembly? the patch ends this message. 
}
}Thanks! I fixed all occurencies in the vger tree.


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
