From: linas@austin.ibm.com
Date: Fri, 30 May 2003 16:48:22 -0500
To: Hollis Blanchard <hollisb@us.ibm.com>
Cc: Hawkins Jeffrey-CJH016 <Jeffrey.F.Hawkins@motorola.com>,
	linuxppc-dev@lists.linuxppc.org, linas@linas.org
Subject: Re: Kernel Panic in 2.2.x
Message-ID: <20030530164822.A28086@forte.austin.ibm.com>
References: <20030530113402.B29314@forte.austin.ibm.com> <7874ED64-92BD-11D7-A2DA-000A95A0560C@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7874ED64-92BD-11D7-A2DA-000A95A0560C@us.ibm.com>; from hollisb@us.ibm.com on Fri, May 30, 2003 at 11:40:49AM -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, May 30, 2003 at 11:40:49AM -0500, Hollis Blanchard wrote:
> On Friday, May 30, 2003, at 11:34 US/Central, linas@austin.ibm.com
> wrote:
> >
> > Latest & greatest is only the best if you are a developer.  For users,
> > old-trustworthy is usually a much better bet.
>
> I disagree,

OK, I can't just let this one slide.

It's hard to say this without sounding personal and insulting, but it
is exactly this sort of attitude on the part of developers that lies
at the root of a lot of the software attrocities commited (of which
I am a guilty, collaborating member).  This sort of an attitude has
got to change; if not, people will curse Linux as much as they curse
Windows.

At various points in my life (including the present) I have had to
sysadmin more than half-a-dozen systems at the same time, and software
upgrades are one of the worst things a sysadmin has to go through.
Things like disk crashes and data loss are pretty bad,  but software
upgrades often result in data loss too, or system outages, or subsystem
outages.  No sysadmin willingly upgrades a working system.

I could barrage you with a litany of personal experiences.  I could
tell you to talk to any sysadmin, who would do the same.   I could
try to remind you of what you went through last time you accidentally
got hammered by an MS Windows upgrade.  Or a debian apt-get upgrade.

I have spent way too much of my life trying to deal with brokeness,
and frankly, I'm kinda getting sick of it.   I'm feeling gun-shy or
shell-shocked or whatever, I get this sinking feeling, 'batten down
the hatches', 'get ready for another all-nighter', 'there goes another
nice sunny weekend' every time I have to contemplate a software upgrade.

Yes, I am venting, but there was a time when I enjoyed maintaining
my own Linux server. Now I hate it, and my hatred is reaching crisis
proportions.  I know that I am not alone.  OK, so what to do?  Can
I steer the conversation back to something positive & constructuive?

I've started writing up some of these problems here:

http://www.linas.org/linux/peeves.html

This url deals more with a hardware outage I had running www.gnucash.org,
(you can read a short version of the saga on the news, there), and
deals primarily with storage issues.   I'll expand this tirade to
include software upgrades: I think I can blame at least some of my
pain on an upgrade of the 'mailman' mailing list software, which
clobbered all of the subscriber lists. I had to downgrade back to the
older version of the software, and restore what I could from backup.

Ugh.

--linas

Hmm. Its tempting to blame the upgrade process, rather than the new
software.  The upgrade process stinks, and needs a complete overhaul.
But sometimes the mere act of upgrading is at fault.  I remember installing
kernel 2.2.13 (or some version like that) and the mouse just stoped
working for no apparent reason.  Even a picture-perfect upgrade
process would still let things like that sneak through: the moral
of the story being that software upgrades are inherently risky.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
