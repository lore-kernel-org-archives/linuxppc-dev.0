Date: Mon, 14 Aug 2000 22:34:26 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Josh Kindler <josh@antihype.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: atyfb problems?
In-Reply-To: <B5BC31B9.2C74%josh@antihype.com>
Message-ID: <Pine.LNX.4.10.10008142231390.3451-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Hmm... I jsut got the latest (as of last night) rsync of Ben's kernel. When
> I compiled it, I got the following error. Previous kernels compiled fine, is
> this a known issue or am I just stupid?
>
> atyfb.c:641: redefinition of `reset_GTC_3D_engine'
> atyfb.c:631: `reset_GTC_3D_engine' previously defined here

Just remove the duplicate code block between lines 631 and 640 of atyfb.c.
Somehow the whole reset_GTC_3D_engine got duplicated. A look at the source
would have spotted that one in no time.

	Michael

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
