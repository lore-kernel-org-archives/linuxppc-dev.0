From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: <mlan@cpu.lu>, <dan_bethe@yahoo.com>
Cc: <nicoya@apia.dhs.org>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 9600 maturity?
Date: Mon, 15 Apr 2002 10:19:58 +0100
Message-Id: <20020415091958.19056@smtp.wanadoo.fr>
In-Reply-To: <E16xBvj-000073-00@piglet.grunz.lu>
References: <E16xBvj-000073-00@piglet.grunz.lu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>No, 2.4 kernels should have solid PCI even in the presence of multiple
>host bridges (which was the problem on the dual-bandit 9x00). The only
>potentially remaining problem could be access to IO space on the second
>bus. Ben, can you comment?

I can't. I would love having someone try this in details and tell me ;)

I suspect the second bandit can only produce "high" IO addresses (thus
precenting use of legacy stuff).


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
