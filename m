From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Etsushi Kato <ekato@ees.hokudai.ac.jp>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: tlbia and PPC603
Date: Wed, 19 Jun 2002 01:55:40 +0200
Message-Id: <20020618235540.7837@smtp.adsl.oleane.com>
In-Reply-To: <20020619201733E.ekato@ees.hokudai.ac.jp>
References: <20020619201733E.ekato@ees.hokudai.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>"isync" just after "sync" in _GLOBAL(_tlbia) in
>arch/ppc/kernel/misc.S.
>
>It appears this change made Performa6200 stable.  Also I tested this
>change on UMAX C500 with linux-2.4.19-pre10, and UMAX C500 also became
>stable.
>
>I'm not sure adding "isync" is good choice, but it seems some problem
>can be solved this.

There are 2 "sync's" in there, which one did you add the isync after ?
The one before tlbia or the one after tlbia ?

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
