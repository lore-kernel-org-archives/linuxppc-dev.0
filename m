Date: Fri, 9 Mar 2001 15:01:12 -0500 (EST)
From: Hollis R Blanchard <hollis+@andrew.cmu.edu>
To: Iain Sandoe <iain@sandoe.co.uk>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: provision of "driver" type facilities from user-space
In-Reply-To: <20010309181506.CB5212F00E@apollo.valhalla.net>
Message-ID: <Pine.LNX.4.21L.0103091500230.2701-100000@unix47.andrew.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 9 Mar 2001, Iain Sandoe wrote:
>
> I want to put a layer in between user-space and a driver (dmasound).
>
> The reason is - that I want to provide facilities (transparently) to
> applications and these facilities cannot be (sensibly) placed in the driver
> [e.g. rate conversion and so on].

Isn't this what esd and arts do?

-Hollis


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
