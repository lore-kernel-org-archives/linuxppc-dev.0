From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: overnight 2.4.11 seems to have used up all memory, slow as a dog
Date: Mon, 8 Oct 2001 16:07:21 +0200
Message-Id: <20011008140721.19291@smtp.adsl.oleane.com>
In-Reply-To: <20011008112806.PUYY27768.tomts5-srv.bellnexxia.net@there>
References: <20011008112806.PUYY27768.tomts5-srv.bellnexxia.net@there>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>Is this a symptom of the "VM" troubles that have kept me away from the
>2.4.X series?
>
>How can I track this one down?
>
>FWIW, this never happens with 2.2.19 at all (I can do long overnight
>builds with no trouble with no slowdowns.

There was at least one VM bug fixed between pre4 and pre5, you
can rsync again (or pull from bk if you are using bk _devel)
to check if it's better.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
