In-Reply-To: <Pine.LNX.4.05.9908262332140.1005-100000@opus.bloom.county>
Date: Fri, 27 Aug 1999 11:20:42 +0200
To: Tom Rini <trini@kernel.crashing.org>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: BootX enhancement request
Message-Id: <19990827112042.001235@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Aug 26, 1999, Tom Rini <trini@kernel.crashing.org> wrote:

>> Thus I can remove the nvram code from atyfb?
>
>Why?  It works fine on lots of older machines w/ ati cards and older MacOS
>versions.  If you remove it I can garrenty people will notice and
>complain.

We should get rid of it for atyfb once we have DDC working. According to
Apple, all machines with ATI controllers are using DDC now. The nvram
setting would still be useful for the older video controllers.

-- 
           Perso. e-mail: <mailto:bh40@calva.net>
           Work   e-mail: <mailto:benh@mipsys.com>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
