From: Benjamin Herrenschmidt <bh40@calva.net>
To: Henning Loeser <Henning.Loeser@Physik.Uni-Marburg.DE>,
        <linuxppc-dev@lists.linuxppc.org>
Subject: Re: ide_dmaproc - YaBoot
Date: Sun, 28 May 2000 15:52:38 +0200
Message-Id: <20000528135238.30201@192.168.1.10>
In-Reply-To: 
 <Pine.OSF.4.02.10005281508190.24780-100000@ax1305.physik.uni-marburg.de>
References: 
 <Pine.OSF.4.02.10005281508190.24780-100000@ax1305.physik.uni-marburg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, May 28, 2000, Henning Loeser <Henning.Loeser@Physik.Uni-
Marburg.DE> wrote:

>What I found seems to have been related to not using yaboot. As I have a
>'old 7500' with MacOS8.1 I thought BootX would be just fine. But maybe
>not. Can I use yaboot on my machine? The WebPages are not very clear on
>that part. BenH's site states that yaboot is onbly for 'NewWorld' macs,
>but Eric's FAQ states that yaboot is for 'NewWorld' macs, but users of
>earlier machines should consider switching if they encounter odd problems
>...
>
>Well I do encounter strange Problems ...
>
>So should I go through the hassel of installing yaboot?

Currently, yaboot will only work on "newworld" type machines. You won't
be able to use it on a 7500. Can you veryfy that bus master is correctly
enabled for your card in the PCI command register ?)

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
