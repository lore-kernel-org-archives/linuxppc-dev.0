From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kaoru Fukui <k_fukui@highway.ne.jp>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: Ben's 2.4.10 problems
Date: Tue, 25 Sep 2001 21:55:41 +0200
Message-Id: <20010925195541.5424@smtp.adsl.oleane.com>
In-Reply-To: <3BB0D8B1.98ED1E7@highway.ne.jp>
References: <3BB0D8B1.98ED1E7@highway.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>I had problems in latest Ben's 2.4.10 compiling.
>The problems are in 12c.c,smp.c,chrp_smp.c.

Thanks. The proper fix is to just remove those 3 #include as
they are useless.

Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
