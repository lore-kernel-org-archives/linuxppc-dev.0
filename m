Date: Wed, 12 May 1999 20:16:16 -0400 (EDT)
From: Tom Rini <tmrini@ntplx.net>
To: Derek Moeller <moeller@networksplus.net>
cc: Ben Martz <benmartz@earthlink.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: linuxppc tree with uusbd
In-Reply-To: <Pine.LNX.3.96.990512182205.11279A-100000@ns1>
Message-ID: <Pine.LNX.4.05.9905122015180.651-100000@pc.wackyland.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 12 May 1999, Derek Moeller wrote:

> On Wed, 12 May 1999, Ben Martz wrote:
> 
> > 
> > Does anyone maintain a linuxppc tree that includes the uusbd package? I
> > would like to get 2.2.7+ up and running on my iMac but obviously the old
> > 2.2.0 uusbd patches can't be applied to the vger tree anymore (as an
> > exercise in futility I tried!). CVS or ftp would be just fine.
> 
> I can get you as close as 2.2.6, I couldn't patch it beyond that (patches
> started failing). That's what I'm running right now. I'd like to see if
> you can patch it further. I don't have it up yet, but I'll put it up maybe
> today/tomorrow at my site (it'll be under /moeller/linux when it does get
> up there).

To get to 2.2.7/8 just back out changes from 2.2.7 for Linus' USB stack.
All in all, getting the new stack working is much more important then
putting the old one in. (in the long run anyhow.)

---
Tom Rini (TR1265)
http://dobbstown.yeti.edu/


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
