Message-Id: <20000216082035.Postino-020573@smtp01.highway.ne.jp>
Date: Wed, 16 Feb 2000 08:20:35 +0900
To: linuxppc-dev@lists.linuxppc.org
From: Kaoru Fukui <k_fukui@highway.ne.jp>
Subject: Re: tracking down the source of compilation trouble
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


From: R Shapiro <reshapiro@mediaone.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: tracking down the source of compilation trouble
Date: Tue, 15 Feb 2000 17:28:43 -0500 (EST)

>
> A few days ago I was surprised to discover that I couldn't compile
> xemacs 21.1.9 on my PMac 7500 (internal compiler error) while I could
> compile it on my beige G3.  These two machines are running the same
> kernel, from the same source tree, and have the same gcc packages
> installed.  Obviously something is different between the two, but
> other than gcc and kernel headers, I don't really know what to look
> for.  What other packages are the most likely source of the differing
> behavior?

You may look configure result and configure.log

Kaoru


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
