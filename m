Date: Wed, 1 Mar 2000 09:49:57 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Andreas Tobler <toa@pop.agri.ch>
cc: Benjamin Herrenschmidt <bh40@calva.net>, paulus@linuxcare.com,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: PPC should not use -fno-builtin (was Re: 2.3.47 imac build?)
In-Reply-To: <38BC513A.9893292D@pop.agri.ch>
Message-ID: <Pine.LNX.4.10.10003010915370.10015-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > Tried both. I get the arch: exit if I set ppc_md.progress in pmac_setup
> > arch. Shortly after this output, the color fringe fun starts again.
> >
> > I'll strip my .config to the bare minimum to narrow this down. Thanks for
> > getting me this far :-)
> Well, I wanted to reply earlier, but unfortunately my telco dropped my
> line for two hours and I was thinking about having destroied my modems
> until I had a look to my /var/log/messages arghhhh.
>
> What I did: I have both trees living around on my PB. I did a diff

Which trees? Unfortunatly I removed 2.3.29 before I could test 2.3.48 ...

> I may post a patch, but I'm not quite satiesfied with since I don't know
> at all what's really necessary. Sorry, but I think it's better not to
> distribute a wrong patch.

Just tell me which files you had to patch :-) I'll start poking around in
drivers/video first. It seems like other parts of the kernel are fine
(sound is switched on, the disk spins up) and it's just atyfb acting
funny.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
