Message-Id: <199908051937.VAA01208@piglet.cpu.lu>
Date: Thu, 5 Aug 1999 21:37:41 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: How DOES OF Work? (ie multi-OS woes)
To: olaph@takilma.nurk.org
cc: iweiny@kdat.csc.calpoly.edu, linuxppc-dev@lists.linuxppc.org,
        linuxppc-user@lists.linuxppc.org
In-Reply-To: <Pine.LNX.4.10.9908041524160.30391-100000@lsd.takilma.or.us>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

Here is more documentation on OF specifically, and as related to the PCI
bus in Macintosh systems.

On   4 Aug, this message from Sean James Swallow echoed through cyberspace:
>> I think the general concensus on this issue is the USERS want BootX or
>> something easy while the Developers and "Power Users," if you will, want to
>> have the flexibility of OF.
> 
> I don't know... It just seems plain silly to me, that to install one OS
> you need another. Nothing to do w/ the users.

I completely agree. BootX is a great tool, but I'd like to not be
forced to use it. At this time I am, as OF is not (yet?) able to boot
my G3-upgraded 7600 using quik.

> There is a little bit of info on the apple site about OF:
> 
> technote 1061 - http://devworld.apple.com/dev/technotes/tn/tn1061.html
> technote 1062 - http://devworld.apple.com/dev/technotes/tn/tn1062.html

The links do not work, but you can find the docs in the numeric index.

> technote 1063 - http://devworld.apple.com/dev/technotes/tn/tn1063.html

This one was never written (tn1063 is actually on a different subject),
and later technote 1044 was declared number three in the series. So
look for tn1044 instead.

But most important for OF, there is this article in the TechInfoLibrary
(TIL) about OF on the AN500/700, which includes a very complete listing
of OF commands:

http://til.info.apple.com/techinfo.nsf/artnum/n60285

Then, there are these two technotes on Rhapsody:

http://developer.apple.com/macosx/server/rhapdev/technotes/RTN0001_Rh_Boot_Process.html
http://developer.apple.com/macosx/server/rhapdev/technotes/RTN0002_Dual_Boot.html

This one here outlines the differences of the NewWorld ROM vs. previous
implementations:

http://developer.apple.com/technotes/tn/tn1167.html

Now, we move more towards PCI-related stuff, but with OF-related
subjects as well. Here is a gem:

'Designing PCI Cards and Drivers for Power Macintosh Computers'
http://developer.apple.com/techpubs/hardware/DeviceManagers/pci_srvcs/pci_cards_drivers/index.html

If you're interested in PCI bus performance, here is an analysis of the
PCI bus performance under MacOS:

TECHNOTE : Understanding PCI Bus Performance
http://developer.apple.com/technotes/tn/tn1008.html

Hope this helps

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
