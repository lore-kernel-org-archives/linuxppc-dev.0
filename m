Date: Sun, 28 Oct 2001 07:03:46 -0700 (MST)
From: Derrik Pates <dpates@dsdk12.net>
To: "Kevin B.Hendricks" <khendricks@ivey.uwo.ca>
Cc: Ani Joshi <ajoshi@shell.unixbox.com>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: GeForce on PPC == _no work_
In-Reply-To: <20011028125007.MHAN10438.tomts12-srv.bellnexxia.net@there>
Message-ID: <Pine.LNX.4.33.0110280701460.22729-100000@andromeda.dsdk12.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 28 Oct 2001, Kevin B.Hendricks wrote:

> Has anyone looked in the latest Darwin release?  Is there code there that
> supports flat panels on both Radeon and Nvidia?  If so, where would one
> look for it?

I've tried browsing the CVS tree via WebCVS, and found one reference, with
an empty directory. It may just use OF framebuffer support on Apple
systems, which would not entirely surprise me. (And of course, the onboard
OF ROM on those boards knows how to deal with ADC/DVI flat panels.)

Derrik Pates      |   Sysadmin, Douglas School   |    #linuxOS on EFnet
dpates@dsdk12.net |     District (dsdk12.net)    |    #linuxOS on OPN


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
