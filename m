Date: Fri, 22 Oct 1999 18:04:19 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Kevin_Hendricks <khendricks@admin.ivey.uwo.ca>
cc: luther@dpt-info.u-strasbg.fr, linuxppc-dev@lists.linuxppc.org
Subject: Re: SuSE Rage 128 Xserver Source and XFree 3.3.6
In-Reply-To: <199910211134.GAA16627@lists.linuxppc.org>
Message-ID: <Pine.LNX.4.05.9910221802400.388-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 21 Oct 1999, Kevin_Hendricks wrote:
> >So is the Rqge 128 driver stuff already in 3.9.16 ?
> 
> According to the list of Xservers given on the XFree86 org page, it is NOT 
> included.  They have completely restructured Xservers for that release.  Now 
> they all start with the base Xserver while calls up various shared-libraries to 
> handle driver specifics / acceleration, etc.
> 
> Given XFree86 policy of not releasing source, (according to their website they 
> specifically request that people *not* join just to get access to pre-release 
> source).  I hope SuSE simply just posts the source.  

In this case people don't join `just to get access to pre-release source', but
`to port it to PPC'. That's real development, so I see no problems with joining
XFree86.

> This whole process simply makes no sense.  Why give development source only to a 
> body that can not release it for others?  Not exactly using the strength of the 
> free software movement?

Those can make time-limited beta binaries.

I don't like it that much neither, and many agree with the not-liking. That's
why there exist 3.9.x snapshots...

Greetings,
--
Geert Uytterhoeven -- Linux/{m68k~Amiga,PPC~CHRP} -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
