From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Steven Hanley <sjh@wibble.net>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: kernel ftp ?
Date: Mon, 16 Jul 2001 09:38:12 +0200
Message-Id: <20010716073812.31069@smtp.wanadoo.fr>
In-Reply-To: <20010716142208.A430@wibble.net>
References: <20010716142208.A430@wibble.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>all the latet kerneles for ppc tend to also be available with rsync, install
>rsync and grab the kernels with something like
>
>benh rsync -avz --delete-after penguinppc.org::linux-2.4-benh .
>
>paulus rsync -avz --delete-after penguinppc.org::linux-pmac-
>{stable,devel,etc} .

Paul no longer maintains his own tree, his work is directly merged
in either bk _2_4 or _2_4_devel now.

>bk rsync -avz --delete-after bitkeeper.fsmlabs.com::linuxppc_2_4 linuxppc_2_4

The bk has moved, I beleive new access infos can be found at
www.penguinppc.org

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
