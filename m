Date: Mon, 25 Jan 1999 19:09:11 -0700 (MST)
From: Cort Dougan <cort@persephone.cs.nmt.edu>
To: Paul.Mackerras@cs.anu.edu.au
cc: hozer@drgw.net, linuxppc-dev@lists.linuxppc.org
Subject: Re: kswapd and SMP still broke on 2.2.0-pre9
In-Reply-To: <199901232325.KAA18504@tango.anu.edu.au>
Message-ID: <Pine.LNX.3.96.990125190836.12469A-100000@persephone.cs.nmt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I get failures.  I get a hang right after MMU_init() with a MP kernel even
on a UP machine.  Same crash I was getting on chrp and smp some time ago.

}Both 2.2.0-pre9 and vger work fine on my 2-processor powermac.  I do
}have some local changes in my tree to do with some extra memory
}barriers etc., but I haven't changed kswapd.  You could try rsyncing
}my current tree from samba.anu.edu.au::linux-pmac-devel to see my
}changes.


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
