Message-ID: <20010205195429.18772.qmail@kunk.jriver.com>
Subject: Re: SOLVED: mesh SCSI bus locks hard on 7500 when burning a CD-R in
In-Reply-To: <Pine.LNX.4.30.0102051934180.18886-100000@opal.biophys.uni-duesseldorf.de>
	"from Michael Schmitz at Feb 5, 2001 08:28:21 pm"
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
Date: Mon, 5 Feb 2001 13:53:31 -0600 (CST)
From: Robert E Brose II <bob@kunk.jriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


User Michael Schmitz says:
>
> Unless Paul had specific reasons not to use the generic NCR53C9x driver
> code for the mac53c94 driver, I'd say we should start from scratch using
> the generic driver code base. I know it looks messy and a lot of the Sparc
> cruft should be stripped out (IIRC Sparc still uses esp.c) but it might be
> worth the trouble.
>
> Problem is, the only Powermacs I could use for testing are a 7100 and a G3
> (233 MHz desktop). Which one of these does use the 53C94?

I just did some online searching and wasn't able to find out. I
think the easiest way to find out would be to boot a kernel on each
machine and check the dmesg. You could just use a YDL or LPPC install
CD on the G3-233 but the 7100 is NuBus so you'd need to try the
experimental NuBus kernel.

I have a spare 7200 which I can use for testing as well.

Bob
--
Robert E. Brose II    N0QBJ
http://www.jriver.com/~bob/
bob@kunk.jriver.com


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
