In-Reply-To: <200003201027.KAA20233@hyperion.valhalla.net>
Date: Mon, 20 Mar 2000 14:45:44 +0100
To: Iain Sandoe <iain@sandoe.co.uk>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: Mac-Side dev-tree dump
Message-Id: <20000320144544.019442@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Mar 20, 2000, Iain Sandoe <iain@sandoe.co.uk> wrote:


>Hello,
>I've taken the extract_devtree stuff from BootX and made a Mac app that
>dumps the tree as formatted text on the Mac.  This was mainly to grab info
>to let me get OF working to the screen on a 9600 - which was driving me mad
>- however it *might* be useful for people wanting info on other H/W - when
>in the "blank screen" phase.
>
>I haven't got a way of posting it for anonymous ftp - but the compressed
>executable is small enough to email (28k) so - within reason - if anyone is
>interested e-mail me directly.  It runs OK on 9600 (604), G3 Mintower(beige)
>& Lombard... which are all I can test on... the NewWorld OF does produce
>some interesting stuff no?
>
>The source + a CW5 project is about 212k (as .sit)
>
>If anyone with a server wants to post it - let me know.
>ciao,
>Iain.

Well, Apple already provides a tool for that. It's called Display Name
Registry, and can be found on their web/ftp site, in the SDK section,
inside the PCI DDK.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
