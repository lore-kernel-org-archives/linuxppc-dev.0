Date: Fri, 26 Mar 2004 13:03:04 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Matt Porter <mporter@kernel.crashing.org>
Cc: Toru UCHIYAMA <uchi@cs.fujitsu.co.jp>,
	linuxppc-dev@lists.linuxppc.org, paulus@samba.org
Subject: Re: [PATCH] Fix memory leak on PPC44x/kernel 2.6.5-rc2-bk
Message-ID: <20040326210304.GA16601@gate.ebshome.net>
References: <200403260934.i2Q9YY324825@stbrain.utsfd.cs.fujitsu.co.jp> <20040326122425.A21727@home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040326122425.A21727@home.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Mar 26, 2004 at 12:24:25PM -0700, Matt Porter wrote:
>
> Paul: Ok to send to akpm?
>

Maybe we should get rid of clear_page in misc.S and make it an inline:

static inline void clear_page(void* page) { clear_pages(page, 0); }

Eugene.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
