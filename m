Reply-To: <joakim.tjernlund@lumentis.se>
From: "Joakim Tjernlund" <joakim.tjernlund@lumentis.se>
To: "Dan Malek" <dan@embeddededge.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: lmw and stmw instructions not used copy functions
Date: Fri, 21 Feb 2003 14:54:42 +0100
Message-ID: <IGEFJKJNHJDCBKALBJLLCEICFKAA.joakim.tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <3E562027.5070701@embeddededge.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Joakim Tjernlund wrote:
>
> > Did some crude benchmarking using clear_page() as my test function.
>
> I'm sure someone has done it before.

I searched this list and the dev list using "lmw" as search key
and it didn't turn up anything relevant.

> What did you use for a benchmark program?

I hacked my own. I just executed clear_page() in userspace a few times
with and without lmw and measured time with gettimeofday(). Not a very
good test but since the difference is so big, I don't think futher tests
are needed.

> You should also be reading the linuxppc-dev
> list, as there are many things like this discussed there.  The
> embedded stuff is just a subset of the global PowerPC development.
> Paul (among many others) has documented many benchmark and optimization
> activities.

Where is this documented? I can't find much in the lists.

 Jocke


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
