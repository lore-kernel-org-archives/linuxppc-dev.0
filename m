Subject: Re: Oops in current linux-2.5-benh
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Wilmer van der Gaast <lintux@lintux.cx>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20031114011048.GG24030@gaast.net>
References: <20031114011048.GG24030@gaast.net>
Content-Type: text/plain
Message-Id: <1068793571.9828.40.camel@gaston>
Mime-Version: 1.0
Date: Fri, 14 Nov 2003 18:06:12 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 2003-11-14 at 12:10, Wilmer van der Gaast wrote:
> Hello,
>
> I assume this list is the best place to report PPC-specific kernel bugs?
> If not, please tell me and I'll repost somewhere else. Please Cc me on a
> reply, I'm not on the list.
>
> On my iBook 600 (CD-ROM/750fx/Radeon), dmasound_pmac fails to load and
> dumps an oops. Attaching the log.
>
> After this oops, trying to get the laptop to sleep also fails with an
> oops, I'm also attaching this dump. But this oops might be caused by a
> previous one; not very useful.
>
> Just testing, the pmud oops also happens without a failed dmasound load.
>
> Hope this dump is of some use, took me some time to type the last one on
> another console. :-)

Does it happen if you built i2c in the kernel instead of as a module ?

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
