Date: Fri, 30 Jul 1999 14:22:28 -0400 (EDT)
From: Tom Rini <trini@disparity.net>
Reply-To: Tom Rini <trini@disparity.net>
To: Aidan Cully <aidan@kublai.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH]: Support for Mouse Systems A3 protocol mice
In-Reply-To: <19990718144949.A764@xanadu.kublai.com>
Message-ID: <Pine.BSF.3.96.990729223411.16262F-100000@silver.teardrop.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 18 Jul 1999, Aidan Cully wrote:

> This patch adds 3-button support for (at least) the Mouse Systems A3
> Trackball, and Mac Point Pro products.  I've also changed a bit of how
> the button-change logic works, since I think it's allowed for mice to
> slip back into the 1-button mouse protocol.  I don't know if that's
> entirely appropriate, but both Darwin and NetBSD seem to take that
> precaution..

Ok.  One problem I've noticed with this patch that the orig. MacX patch
didn't have is sometimes in X middle-clicking in NS spawns 2 windows
(up&down event repeated).  This is with an A3 optical.

http://gate.crashing.org/~trini/



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
