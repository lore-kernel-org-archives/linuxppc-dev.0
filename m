Date: Fri, 19 Feb 1999 00:31:25 -0700 (MST)
From: Cort Dougan <cort@persephone.cs.nmt.edu>
To: Paul.Mackerras@cs.anu.edu.au
cc: zankel@tarantel.rz.fh-muenchen.de, bh40@calva.net, davidsen@prodigy.com,
        marsmail@globegate.utm.edu, dvdoug@tiac.net, paubert@iram.es,
        jskov@cygnus.co.uk, hozer@drgw.net, linuxppc-dev@lists.linuxppc.org
Subject: Re: [ppc-dev] Summary: Restructuring Efforts
In-Reply-To: <199902190612.RAA00610@tango.anu.edu.au>
Message-ID: <Pine.LNX.3.96.990219002612.9708A-100000@persephone.cs.nmt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


My concern here is that moving things to vger/linus could be difficult if
the trees diverge too much.  It might sometimes be necessary to revert
some changes because they're not ready yet or break things.  I think that
detail can be worked out then, though.

}another one where we put stuff once it is tested and known not to
}break things for most users.  The second tree would then be the one

If vger were the stable tree, that would be great.  I'd like more of the
community able to get their hands on things through the dev tree rather
than having to grab day old tar files from me.

}If we do that, then we can give relatively wide access to the
}development tree, and restrict access to the stable tree to one or two
}people (Cort and I, maybe).  That way the divergence of the stable
}tree from Linus' could be controlled.

If I'm setting it up and maintain it I'd prefer it here.  I can more
easily fix things and setup things that way.  Hosting the mail exploder
and a mirror at linuxppc.org would be great.

}Ideally the trees should provide read-only rsync access since that is
}so much more efficient for people who are a long way from the cvs
}server.
}
}I would think that dev.linuxppc.org is probably the best place to keep
}these trees.


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
