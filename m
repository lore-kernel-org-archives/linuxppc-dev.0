From: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
To: "Robert E Brose II" <bob@kunk.jriver.com>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: Missing iBook HD driver?
Date: Sat, 21 Sep 2002 13:52:19 +0200
Message-Id: <20020921115219.9126@192.168.4.1>
In-Reply-To: <20020920201320.14193.qmail@kunk.jriver.com>
References: <20020920201320.14193.qmail@kunk.jriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>After corresponding with Ben H. on this and doing some testing
>I reached the conclusion that:
>
>If you have a dvd/cd-rw combo drive on a 600 mhz ibook the
>stock 2.4 kernels will not recognise it. Ben has fixed this in
>his kernel and I found an old reference in the faq-o-matic
>(to an iMac) that you can work around it by specifying
>
>hda=16383,16,63
>
>as a kernel arg when booting from the install cd. I thought
>I'd drop the info here so others can search it out when they
>run into the same problem...

I don't recommend the kernel arg thing. There is indeed
a workaround that seem to work properly in my current tree,
I'll try to get that merged upstream.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
