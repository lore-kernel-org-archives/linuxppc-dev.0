Message-ID: <3A6C7795.4796F29@mvista.com>
Date: Mon, 22 Jan 2001 13:10:29 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Tom Gall <tgall@rochcivictheatre.org>
CC: Troy Benjegerdes <hozer@drgw.net>, linuxppc_commit@hq.fsmlabs.com,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: context overflow
References: <3A68F7A0.693639F1@mvista.com> <20010121222842.A27103@altus.drgw.net> <3A6BB971.7F128273@rochcivictheatre.org>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tom Gall wrote:

> I will look into this tomorrow.  It's an important fix, I don't want to rush.

This was a bug that appeared during the 2.3 development, and (the
collective :-) we have been running systems like this for a long
time.  I'm running all of mine with my proposed (proper :-) bug
fix, but since they never crashed before......I'll at least check
it into the 2_5 baseline along with some other stuff.


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
