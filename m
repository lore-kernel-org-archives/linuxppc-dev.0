Message-ID: <006a01c2e1da$e108ddd0$020120b0@jockeXP>
From: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
To: "Dan Malek" <dan@embeddededge.com>
Cc: <linuxppc-dev@lists.linuxppc.org>, <drow@false.org>
References: <005401c2e0e4$27a1b6b0$020120b0@jockeXP> <3E63C6BE.6020002@embeddededge.com>
Subject: Re: Improved copy_page() function, about 30% speed up for mpc860!
Date: Tue, 4 Mar 2003 00:16:10 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Joakim Tjernlund wrote:
>
> > I found a link that may have relevance regarding  the dcbz problem , can anybody confirm this?
> > http://www.uwsg.iu.edu/hypermail/linux/kernel/0012.0/0529.html
>
> This is just one of the many different things that happen with various
> silicon versions and the use of the cache instructions on the 8xx.
> In this particular case, we have fixed this "bug" because it affects
> other load/store instructions under some conditions (i.e. this isn't
> unique to the cache instructions).

OK so this is not it then, but what is it then? Are you 100% that
the bug(whatever this may be) is present for mpc860, rev D4 or later?
How can I make it bite me on kernel space memory?
I can't find that info in the archives, if it's there please give me a hint.

I have enabled all kernel functions that uses dcbz for 8xx as well. I even split copy_tofrom_user
into copy_from_myuser resp. copy_to_myuser and enabled dcbz in copy_from_myuser
and still everything is working just fine.

     Jocke


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
