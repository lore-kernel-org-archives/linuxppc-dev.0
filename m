From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kaoru Fukui <k_fukui@highway.ne.jp>
Cc: <linuxppc-dev@lists.linuxppc.org>, <paulus@samba.org>,
	<cort@fsmlabs.com>
Subject: Re: Fwd: CPU features
Date: Sun, 1 Apr 2001 22:11:10 +0200
Message-Id: <20010401201110.30859@smtp.wanadoo.fr>
In-Reply-To: <20010402041101.Postino-017970@smtp01.highway.ne.jp>
References: <20010402041101.Postino-017970@smtp01.highway.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Your fix  is very nice.
>I could run fine smp-kernel-2.4.3 which your patch to penguinppc's 2.4-bk.
>
>Last one is a problem of "smp_core99_kick_cpu" on your tree.

I reverted that change until I can test it on the dual G4.

ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
