Date: Tue, 4 Dec 2001 11:15:52 -0700 (MST)
From: Derrik Pates <dpates@dsdk12.net>
To: "Kevin B.Hendricks" <kevin.hendricks@sympatico.ca>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Rage128 support for resolutions less than panel resolution?
In-Reply-To: <20011204175547.WVJL16262.tomts14-srv.bellnexxia.net@there>
Message-ID: <Pine.LNX.4.40.0112041108131.11201-100000@andromeda.dsdk12.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 4 Dec 2001, Kevin B.Hendricks wrote:

> This should work to change your resolution to whatever you want as long as
> the "scaling register code" patch I saw fly by recently (a couple of weeks
> ago) actually made it into the aty128fb.c code yet.

Ah. I looked back through the folder I have for this list - turns out I
still had the message with the patch tacked on in the box! Yay! I'm
rebuilding the kernel (2.4.17-pre2-ben0, so no, it's not even in Ben's
tree yet) as I type, so hopefully this will make 640x480 work acceptably
on this iBook. It'd be nice for running MoL fullscreen, without having to
run it in 800x600 all the time...

Derrik Pates      |   Sysadmin, Douglas School   |    #linuxOS on EFnet
dpates@dsdk12.net |     District (dsdk12.net)    |    #linuxOS on OPN


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
