Date: Wed, 12 May 1999 19:30:29 -0500 (CDT)
From: Derek Moeller <moeller@networksplus.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: linuxppc tree with uusbd
In-Reply-To: <Pine.LNX.4.05.9905122015180.651-100000@pc.wackyland.com>
Message-ID: <Pine.LNX.3.96.990512192847.11500A-100000@ns1.networksplus.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 12 May 1999, Tom Rini wrote:

> On Wed, 12 May 1999, Derek Moeller wrote:
> 
> > On Wed, 12 May 1999, Ben Martz wrote:
> > 
> > > 
> > > Does anyone maintain a linuxppc tree that includes the uusbd package? I
> > > would like to get 2.2.7+ up and running on my iMac but obviously the old
> > > 2.2.0 uusbd patches can't be applied to the vger tree anymore (as an
> > > exercise in futility I tried!). CVS or ftp would be just fine.
> > 
> > I can get you as close as 2.2.6, I couldn't patch it beyond that (patches
> > started failing). That's what I'm running right now. I'd like to see if
> > you can patch it further. I don't have it up yet, but I'll put it up maybe
> > today/tomorrow at my site (it'll be under /moeller/linux when it does get
> > up there).
> 
> To get to 2.2.7/8 just back out changes from 2.2.7 for Linus' USB stack.
> All in all, getting the new stack working is much more important then
> putting the old one in. (in the long run anyhow.)

Isn't OHCI support really shaky for the new stack though? I know they've
got UHCI support down pretty well, but I don't know how the iMac would
fare with the current new stack drivers.

--

+--------------------------------------+
 Derek Moeller moeller@networksplus.net 
     Linux for PowerPC User, Student    
   http://www.networksplus.net/moeller	 
    "aut inveniam viam aut faciam"	 
+--------------------------------------+


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
