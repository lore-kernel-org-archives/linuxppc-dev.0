Message-Id: <20010705174428.Postino-006498@smtp01.highway.ne.jp>
Date: Thu, 5 Jul 2001 17:44:28 +0900
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linuxppc-dev@lists.linuxppc.org
From: Kaoru Fukui <k_fukui@highway.ne.jp>
Subject: Re: __divdi3 unresolved + X pointer blocks
In-Reply-To: <Pine.LNX.4.05.10107051012150.10817-100000@callisto.of.borg>
References: <200107042318.TAA26354@makai.watson.ibm.com>
 <Pine.LNX.4.05.10107051012150.10817-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


From: Geert Uytterhoeven <geert@linux-m68k.org>
To: David Edelsohn <dje@watson.ibm.com>
Subject: Re: __divdi3 unresolved + X pointer blocks
Date: Thu, 5 Jul 2001 10:13:16 +0200 (CEST)
cc: Kaoru Fukui <k_fukui@highway.ne.jp>, Jean-Jacques.Levy@inria.fr,Benjamin
Herrenschmidt <benh@kernel.crashing.org>,linuxppc-dev@lists.linuxppc.org

> On Wed, 4 Jul 2001, David Edelsohn wrote:
> > 	You do not seem to have understood my reply.  I will repeat the
> > important sentence:
> >
> > 	SHIFT IS NOT THE SAME AS DIVIDE FOR SIGNED INTEGERS.
>
> Indeed. That's why you have `logical shift right' and `arithmetic shift right
'.
> The former inserts zeroes, the latter inserts a copy of the MSB.
>
> Don't know from memory whether PPC has them...
>

Thanks your explain.

I alway used them when Z80 Assmble probramming ,long long time ago -:)

Kaoru


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
