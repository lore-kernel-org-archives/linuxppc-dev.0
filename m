Date: Fri, 28 Sep 2001 07:23:23 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: MATSUURA Takanori <t-matsuu@protein.osaka-u.ac.jp>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: broken symlinks
Message-ID: <20010928072323.P23005@cpe-24-221-152-185.az.sprintbbd.net>
References: <20010927.163320.846962931.t-matsuu@protein.osaka-u.ac.jp> <20010928.205654.730556547.t-matsuu@protein.osaka-u.ac.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010928.205654.730556547.t-matsuu@protein.osaka-u.ac.jp>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Sep 28, 2001 at 08:56:54PM +0900, MATSUURA Takanori wrote:

> I think this is NFS server-side problem. When I downgraded my LinuxPPC
> kernel of NFS Server from 2.4.10 to 2.4.10-pre2, the problem does not
> occured.

Then it's quite probably related to some of the NFS changes that went in
after pre2.  The prepatches are still around, so see how far you can go
before it breaks.  Also, try searching the NFS lists and linux-kernel.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
