Date: Fri, 12 Feb 1999 13:16:50 +0100 (MET)
From: Niels Roest <N.P.Roest@ITS.TUDelft.NL>
Subject: Re: Adventures with KDE-1.1
In-reply-to: <Pine.LNX.4.00.9902111928330.4101-100000@blackcat.cat.syr.edu>
Cc: linuxppc-dev@lists.linuxppc.org
Message-id: <Pine.HPP.3.95.990212131032.17563B-100000@elektron.et.tudelft.nl>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Thu, 11 Feb 1999, Fred Dushin wrote:

> 
> 
> In case anyone is interested...
> 
> I downloaded the kde 1.1 tarballs and had a go building.
> But first I updated egcs as much as I could off of linuxppc.org.
> 
> BTW, is this the place to look for bleeding edge stuff?  Doesn't
> look like it, by the dates.
> 
> [root@blackcat /downloads]# rpm -qa | grep egcs
> egcs-as-gcc-1.1-0a
> egcs-c++-1.1-0a
> egcs-libstdc++-2.8.0-2b
> egcs-1.1-0a
> egcs-libstdc++-devel-2.8.0-2b
> [root@blackcat /downloads]# rpm -qa | grep glibc
> glibc-devel-0.961212-1l
> glibc-info-0.961212-1h
> glibc-static-0.961212-1l
> glibc-0.961212-1l
> 
> qt-1.42 built without a hitch.

I downloaded kde 1.1 tarballs too. I seem to have newer
versions altogether, rpm -qa | grep egcs gives
egcs-1.1.1-1c
egcs-c++-1.1.1-1c
egcs-g77-1.1.1-1c
egcs-objc-1.1.1-1c
and rpm -qa | grep glibc
glibc-2.0.108-1c
glibc-debug-2.0.108-1c
glibc-devel-2.0.108-1c
glibc-profile-2.0.108-1c
cause I upgraded to pre-R5 (daring!!)
I think I got qt-1.42 there too.
My kernel (thus my linux & asm headers) is 2.2.1.

<snip some problems>
> Turned off HAS_ARGZ in config.h.
> Further down, I ran into a mess of problems, mostly around header
<snip>
> Thanks,
> Fred

I had no problems whatsoever.
So Fred, it seems upgrade would solve it.

Niels


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
