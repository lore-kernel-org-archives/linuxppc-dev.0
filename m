From: Benjamin Herrenschmidt <bh40@calva.net>
To: Marc Dietrich <Marc.Dietrich@hrz.uni-giessen.de>,
        <linuxppc-dev@lists.linuxppc.org>
Subject: Re: asm statement in include/asm not ansi conform
Date: Fri, 1 Sep 2000 13:03:26 +0200
Message-Id: <20000901110326.11355@mailhost.mipsys.com>
In-Reply-To: <Pine.A41.4.21.0009011115240.32258-100000@c2.hrz.uni-giessen.de>
References: <Pine.A41.4.21.0009011115240.32258-100000@c2.hrz.uni-giessen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>I fear this won't help much in my case (with b&w G3). Anyway there's still
>a lot to do. DRI is very unstable and it seems that some functions are
>missing.
>
>Thanks for your great work

Yes, it may help. AFAIK, the R128 also supports a "PCI GART" and I do
intend to make sure my driver can handle those too (since supporting a
PCI GART involves pretty much the same thing as supporting the Uni-N AGP
GART).

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
