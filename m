MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14505.54043.936537.924610@ipa.ne.mediaone.net>
Date: Tue, 15 Feb 2000 17:28:43 -0500 (EST)
From: R Shapiro <reshapiro@mediaone.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: tracking down the source of compilation trouble
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


A few days ago I was surprised to discover that I couldn't compile
xemacs 21.1.9 on my PMac 7500 (internal compiler error) while I could
compile it on my beige G3.  These two machines are running the same
kernel, from the same source tree, and have the same gcc packages
installed.  Obviously something is different between the two, but
other than gcc and kernel headers, I don't really know what to look
for.  What other packages are the most likely source of the differing
behavior?

--
reshapiro@mediaone.net


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
