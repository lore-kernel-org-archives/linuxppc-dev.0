Date: Sun, 11 Feb 2001 00:13:34 -0600
From: "Joseph P. Garcia" <jpgarcia@execpc.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: BMAC stuff - what I have
Message-Id: <20010211001334.54abdf4f.jpgarcia@execpc.com>
In-Reply-To: <20010211043822.8854.qmail@kunk.jriver.com>
References: <20010211043822.8854.qmail@kunk.jriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 10 Feb 2001 22:38:22 -0600 (CST), Robert E Brose II <bob@kunk.jriver.com> wrote:
> I see the same problem on my Rev C iMac at 100 mb in both 2.2 and 2.4
> kernels. I get slow transfers and broken scp's but not corrupted
> data on complete transfers. Same machine works fine in MacOS and OSX.
>
> Bob

Thanks for the input.

If it is true that the iMac has the same Tx problem, since they have always used BMAC+ (AppleSpec: 10/100 on all iMacs), I guess that this would mean that BMAC+ can also have this bug.  Can any one confirm this with an additional case?

It seems rather erratic on which systems are afflicted.  My brother's lombard is not affected, nor a wallstreet confirmed built after mine, which is.

In anycase, enough talk.  Anyone know dbdma well enough to approach a fix? :)

--
Joseph P. Garcia
http://www.execpc.com/~jpgarcia

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
