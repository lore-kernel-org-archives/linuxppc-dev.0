Date: Mon, 26 Mar 2001 14:32:45 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: linuxppc-commit@fsmlabs.com, linuxppc-dev@lists.linuxppc.org
Subject: Anon BK mirror
Message-ID: <20010326143245.Q16672@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hey all!  All of the BK trees are currently being mirrored on source.mvista.com

So, if y'all wanna save some bandwidth for the writing people <g> you can do:
$ bk parent bk://source.mvista.com/XXXX

Where XXXX is either linux_2_4, linux_2_2, linuxppc_2_2, linuxppc_2_4 or
linuxppc_2_5.  These mirrors should get updated automagically shortly after the
commit message hits linuxppc-commit.  If any problem show up, please shoot me
an email privately and I'll see what I can do.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
