Date: Sun, 3 Jan 1999 19:31:49 -0500 (EST)
From: Hollis R Blanchard <hollis+@andrew.cmu.edu>
Reply-To: Hollis R Blanchard <hollis+@andrew.cmu.edu>
To: Sam Quigley <osquigle@cs.uchicago.edu>
cc: linuxppc-user@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: FTP Problems
In-Reply-To: <o9un240gfbb.fsf@yeenoghu.cs.uchicago.edu>
Message-ID: <Pine.LNX.3.96L.990103184911.3513C-100000@unix49.andrew.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 3 Jan 1999, Sam Quigley wrote:

> > OK, so it can't open the RPMS database, right? Can you switch to virtual
> > console 3 (Cmd-F3) or 4 and see if there's a specific error listed? That
> > might be a little more helpful than the installer errors message.
> 
> I have this problem too: the error reported is, on console 3:
> 
> * ugFindUpgradePackages() ...
> * failed opening /mnt/var/lib/rpm/packages.rpm
> 
> the installer warns that 'an error occurred during step "Choose
> packages to upgrade"', but also has a stray line reading
> "/mnt/var/lib/rpm/nameindex.rpm:" on the background.  (this is,
> presumably, an error message from something other than the installer)
> 
> I can cat packages.rpm fine from the console.

Hmm. I am *not* an expert on the RedHat installer, but what's in packages.rpm?
And how about nameindex.rpm?

I expect we'll get a little help once people get settled after MacWorld. Which
reminds me, I was hoping I could get a list of the various people working on
R5 and what they're doing. Just curious, plus it would make it easy to have a
dialogue with the person(s) working on the RedHat installer.

-Hollis



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
