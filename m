Reply-To: <joakim.tjernlund@lumentis.se>
From: "Joakim Tjernlund" <joakim.tjernlund@lumentis.se>
To: "Dan Malek" <dan@embeddededge.com>,
	"Daniel Jacobowitz" <drow@false.org>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: RE: Improved copy_page() function, about 30% speed up for mpc860!
Date: Tue, 4 Mar 2003 09:29:03 +0100
Message-ID: <IGEFJKJNHJDCBKALBJLLIEMEFKAA.joakim.tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <3E641FCF.7080307@embeddededge.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Daniel Jacobowitz wrote:
>
> > That is, in fact, incorrect.  It's fatal from userland.  I experimented
> > with it just a couple of months ago.
>
> Uh oh....was this discussed and I missed it?
>
> Will you fill me in on what you were trying to do and how it failed?

I and Daniel discussed it, mostly in private. It fails horribly for
me too in user space(init hangs, don't know any details) and that's why
I split copy_tofrom_user into 2 functions( see yesterdays mail) as a test. With that
change my system is stable.

   Jocke


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
