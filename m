From: Benjamin Herrenschmidt <bh40@calva.net>
To: Gavin Hemphill <hemphill@drea.dnd.ca>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: mprotect and SMP
Date: Thu, 7 Dec 2000 14:15:05 +0100
Message-Id: <19341101064649.16824@192.168.1.2>
In-Reply-To: <3A2F82B3.46C4C2E0@drea.dnd.ca>
References: <3A2F82B3.46C4C2E0@drea.dnd.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>This problem has existed since the earliest kernels I've had for the
>gemini (about 2.2.13).
>
>I've got read access to the bk tree now, the problem is that it doesn't
>boot when configured for the gemini, I'm going to look through the
>gemini specific diffs and try and get the 2_2 tree running, but from
>what I've seen in the larger set of diff's there's no modifications that
>seem to apply to the mprotect problem.  Just out of curiosity, if I do
>get the gemini configuration running who do I send the changes to so
>that they make it back into the tree.
>	Gavin

Send them to this list, CC to me & paulus, eventually submit them to the
sourceforge site.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
