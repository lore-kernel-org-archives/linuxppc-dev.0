Date: Wed, 4 Aug 1999 15:45:30 -0700 (PDT)
From: Sean James Swallow <olaph@takilma.nurk.org>
To: "Ira K. Weiny" <iweiny@kdat.csc.calpoly.edu>
cc: linuxppc-dev@lists.linuxppc.org, linuxppc-user@lists.linuxppc.org
Subject: Re: How DOES OF Work? (ie multi-OS woes)
In-Reply-To: <199907302109.OAA02303@kdat.csc.calpoly.edu>
Message-ID: <Pine.LNX.4.10.9908041524160.30391-100000@lsd.takilma.or.us>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> I think the other side really is for those who don't want to boot the MacOS
> at all.  I have had LinuxPPC for 2 years now booting from OF and I almost
> got rid of my MacOS partition long ago but thought the best of it.  Now that
> I have R5 I am glad I could at least use MacOS to get it installed but I
> would still like to have a solution where I would not NEED the MacOS to
> boot.

Amen! I have no mac partition, as I haven't since day one.

> Furthermore, beyond having multiple OS's like NetBSD and BeOS I still have
> my OLD release of LinuxPPC.  It is WAY older than even R4 and the only way I
> have of booting it is through OF.  

I boot R5 via OF. =)

> I think the general concensus on this issue is the USERS want BootX or
> something easy while the Developers and "Power Users," if you will, want to
> have the flexibility of OF.

I don't know... It just seems plain silly to me, that to install one OS
you need another. Nothing to do w/ the users.

> Anyway it is just my humble opinion that both should be supported.  However,
> as a USER hoping to be a "Power User" and even devloper some day, I would
> like to see some documentation on how to use OF to boot R5, ANY URL's?
> My main question is "HOW THE HECK DOES OF WORK?"

There is a little bit of info on the apple site about OF:

technote 1061 - http://devworld.apple.com/dev/technotes/tn/tn1061.html
technote 1062 - http://devworld.apple.com/dev/technotes/tn/tn1062.html
technote 1063 - http://devworld.apple.com/dev/technotes/tn/tn1063.html

Chris Ridd also posted some OF command info from Sun's site a while ago.

        http://www.sun.com/pci/pci/pcidevkit/fcodeaac.ps

and there's an OpenBoot 3.x supplement for PCI at:

        http://www.sun.com/pci/pci/pcidevkit/obp_3aag.ps

And there's also a sample PCI Fcode driver at:

        http://www.sun.com/pci/pci/pcidevkit/samplaan.fth


I wish you good luck... Maybe you could come up w/ a way to boot from a
selection of OS'es via OF. But the mac crowd will still wine, as there is
no icons to click on in OF... =/

Sean


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
