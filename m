In-Reply-To: <v04220802b500d91f6693@[10.0.0.42]>
Date: Fri, 24 Mar 2000 14:12:55 +0100
To: "Timothy A. Seufert" <tas@mindspring.com>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: LongTrail PCI resource assignment
Message-Id: <20000324141255.013260@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Mar 24, 2000, Timothy A. Seufert <tas@mindspring.com> wrote:

>If there was a really, really good reason to keep OF up to date
>(like, say, if we could break back into the OF console like you can
>on Sparcs), then it would be OK.  Otherwise it is most likely
>unnecessary bloat, and leads to potential confusion (and bugs).  Is
>there any such reason on ppc?

After thinking a bit more about this, I beleive we could simply add a
property to the nodes of cards for which we change the bus number,
indicating the new linux pci dev infos. The way, we keep the "reg"
property intact (it may be useful for rebuilding OF path).


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
