Message-ID: <3E63C6BE.6020002@embeddededge.com>
Date: Mon, 03 Mar 2003 16:18:54 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Joakim Tjernlund <Joakim.Tjernlund@lumentis.se>
Cc: linuxppc-dev@lists.linuxppc.org, drow@false.org
Subject: Re: Improved copy_page() function, about 30% speed up for mpc860!
References: <005401c2e0e4$27a1b6b0$020120b0@jockeXP>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Joakim Tjernlund wrote:

> I found a link that may have relevance regarding  the dcbz problem , can anybody confirm this?
> http://www.uwsg.iu.edu/hypermail/linux/kernel/0012.0/0529.html

This is just one of the many different things that happen with various
silicon versions and the use of the cache instructions on the 8xx.
In this particular case, we have fixed this "bug" because it affects
other load/store instructions under some conditions (i.e. this isn't
unique to the cache instructions).


	-- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
