Message-ID: <3910E527.75AEF846@erols.com>
Date: Wed, 03 May 2000 22:49:11 -0400
From: Nelson Abramson <pogtal@erols.com>
MIME-Version: 1.0
To: Rob Cascella <rob@schizophrenia.dfjp.com>
CC: john peter grimes <jpgrimes@rainbow.uchicago.edu>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: KDE 2.0 compilation problems
References: <200005040057.UAA02407@schizophrenia.dfjp.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Rob Cascella wrote:

> I don't know if it's related or not, but I've been trying to compile
> something with g++ and have been getting an error message saying that
> the compiler couldn't create executables.  I tried recompiling gcc,
> but it didn't seem to help.  And, now that I think about it, I'd like
> to try to resolve this issue, so, can anyone help me with this?  I'd
> appreciate it..

This has come up quite a few times on the user list.  You need to have the full
range of gcc related files; binutils, glibc, libstdc, cpp, etc.  Search the
archives for the complete list.

HTH
--Nelson Abramson

--
"Apparently if you play the Windows NT CD backwards you hear satanic messages"
"You think that's bad, if you play it forwards it installs Windows NT!"
--orlando


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
