Date: Mon, 9 Aug 1999 15:28:07 -0400 (EDT)
From: Tom Rini <trini@disparity.net>
Reply-To: Tom Rini <trini@disparity.net>
To: Paul.Mackerras@cs.anu.edu.au
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Trying a Promise Ultra/66 on powerpc
In-Reply-To: <199908090602.QAA13922@tango.anu.edu.au>
Message-ID: <Pine.BSF.3.96.990809145017.16262j-100000@silver.teardrop.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 9 Aug 1999, Paul Mackerras wrote:

> Tom Rini <trini@disparity.net> wrote:
> 
> > Would this be one of the things solved/cleaned up by seperating ide-pmac.c
> > and the CONFIG option for it into generic enable IDE stuff and a driver
> > for the builtin IDE on some machines?  Last I tried, I needed to enable
> > both cmd646 and ide-pmac on myy blue&white (trying to do this is on my
> > todo list, someplace.. :))
> 
> There's no problem about enabling both cmd646 and ide-pmac with the
> current vger sources, is there?  You do need to select experimental
> drivers as well as "Generic PCI IDE chipset support"
> (CONFIG_BLK_DEV_IDEPCI) and "Generic PCI bus-master DMA support"
> (CONFIG_BLK_DEV_IDEDMA) before you get asked about the CMD646, though.

Right, the problem comes from enabling CMD646 but not ide-pmac.  Right now
to use any IDE chipset on a pmac, you need to say yes to "Builtin PowerMac
IDE support" and whichever chipset you have (to boot at least, I'll check
being able to use it once I can boot off something else, but it sounds
like there might be a problem there as well).

---
Tom Rini (TR1265)
http://gate.crashing.org/~trini/




[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
