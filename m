Date: Wed, 11 Aug 1999 11:25:15 +0200
From: Hubert Figuiere <hfiguiere@teaser.fr>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.rutgers.edu, linuxppc-dev@lists.linuxppc.org
Subject: Re: HFS+ support?
Message-ID: <19990811112515.H18601@rhodan.businessobjects.com>
References: <im1n1vz8a8x.fsf@chimera.sd.us.am.ericsson.se> <E11ETx3-0003xt-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E11ETx3-0003xt-00@the-village.bc.nu>; from Alan Cox on Wed, Aug 11, 1999 at 09:41:33AM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


According to Alan Cox <alan@lxorguk.ukuu.org.uk>:
> 
> > Are there current efforts to make this filesystem available?  If so,
> > where can I find more information and possibly assist?  If not, what's
> > the right way to start such an effort?
> 
> Have Apple put out any HFS+ documentation yet ?

Yes (updated in March 1999)

Technical Note 1150 does provide enough information (aparently)
to write support for HFS+:

http://developer.apple.com/technotes/tn/tn1150.html

Darwin OS source code (from http://publicsource.apple.com/)
contains a working HFS+ file system implementation that can be
used as a reference in case of lacks in the documentation.


Hub

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
