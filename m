Message-ID: <39B56579.9AEED836@student.ethz.ch>
Date: Tue, 05 Sep 2000 23:28:25 +0200
From: Michel Dänzer <daenzerm@student.ethz.ch>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: TCP problems in 2.4
References: <39B4B5A4.502388B@relog.ch>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michel Dänzer wrote:
>
> I rsynced bitkeeper test 8 a few days ago and the same TCP problems I had
> experienced with pmac-devel are still there.
>
> I suspect it's the TCP congestion notification, will try without that, has
> anyone tried it?

That seems to be the case, it works here with a different ISDN router. I'll
try at the other place with this feature disabled and report success or
failure (just in case anyone is interested :)


Michel


--
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86 and The DRI Project

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
