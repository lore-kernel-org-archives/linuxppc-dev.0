Message-ID: <37558CC8.A5025227@wanadoo.fr>
Date: Wed, 02 Jun 1999 21:58:00 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: satadru pramanik <satadru@umich.edu>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: compilation failure of 2.2 series cvs kernel sources
References: <Pine.LNX.4.10.9906021228590.15449-100000@beer.pub.umich.edu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


satadru pramanik wrote:
> 
> yes. I did upgrade glibc recently. ;-)
> 
> However, the symlink is still the same.   Do I need to change it?  And
> wouldn't doing a cvs update change the scsi.h file "back"?  Or is that the
> problem?

I don't really know what happens in this case, but it shouldn't be hard
to find out what version of include/scsi/scsi.h (and sg.h, which sits in
the same boat) you have: "cvs status include/scsi/scsi.h".
BTW, cvs log tells me that TYPE_ENCLOSURE came into scsi.h on February
9, version 1.10.

--
Martin

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
