From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ethan Blanton <eblanton@cs.ohiou.edu>,
	<linuxppc-dev@lists.linuxppc.org>, Jeremy Radlow <jtr@sourcerers.com>
Subject: Re: Internal airport card not working? (2.4.6-benh)
Date: Sun, 15 Jul 2001 22:11:18 +0200
Message-Id: <20010715201118.9038@smtp.wanadoo.fr>
In-Reply-To: <20010714131255.A13317@localhost.localdomain>
References: <20010714131255.A13317@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>I'm running BenH's 2.4.6 from about a week ago, and I get similar
>behavior...  *eventually* I find the destination and connect or
>whatever, but it takes quite a few seconds.
>
>Removing the driver stack (airport, orinoco, hermes) and reinserting
>the modules fixes the problem for me...  Until I suspend and resume a
>few times, at which point I'll have to remove/reinsert again.
>
>I know that's not a *fix*, but it should get you working again in the
>meantime.  :-)
>Ethan

Interesting. Do you see any error message in the dmesh log ?

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
