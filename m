Date: Wed, 24 Mar 1999 23:32:01 -0500 (EST)
From: "David T. McWherter" <dtm@vramp.net>
To: Cort Dougan <cort@ppc.kernel.org>
cc: Darron Froese <darron@calgary.westworld.ca>,
        linuxppc-dev@lists.linuxppc.org,
        linuxppc-ans-support@hellfire.dusers.drexel.edu
Subject: Re: ANS Patches en route to the 2.2.x kernel?
In-Reply-To: <19990323205715.A15285@persephone.ppc.kernel.org>
Message-ID: <Pine.NEB.3.96.990324232731.28326B-100000@water.vramp.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Just another bit of good news:

v2.2.4 is up on 
ftp://hellfire.dusers.drexel.edu/pub/linuxppc/v2.2.4
And soon will be finished uploading to 
ftp://linuxppc.cs.nmt.edu/pub/linuxppc/patches/ans/v2.2.4

And the good news is that it seems that if you give it
a 'root=/blah' argument during bootup, it'll boot from
the internal scsi chain (at least it does so for us).

The file listing:

	patches.tgz - The files changed in the source tree (from vger)
	linux-pmac-2.2.1.ans.tgz - The modified source tree
	vmlinux(_2.2.4) - The compiled kernel

-David

On Tue, 23 Mar 1999, Cort Dougan wrote:

> Watch vger.  That's where all the patches go through for PPC.
> 
> I don't have an up-to-date copy of the ANS patches but should be getting
> them soon.  ANS is on its way into the main kerenl but has taken quite a
> while, yes.
> 
> } Is there a way to look and see if various patches have been
> } sent/accepted/waiting in queue? I've grepped through some of the latest
> } patches without finding it....anyone know where it is and it's status?
> 

-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
       David T. McWherter     dtm@waterw.com


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
