Date: Wed, 25 Jun 2003 01:49:51 -0500
From: Chris Zimman <chris@cryptoapps.com>
To: Conn Clark <clark@esteem.com>
Cc: May Ling List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: (Sudo off topic)Simple cheap IDE intrerface for IBM 405
Message-ID: <20030625064951.GA12559@dingdong.cryptoapps.com>
Reply-To: Chris Zimman <chris@cryptoapps.com>
References: <3EF8CDF4.3050700@esteem.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3EF8CDF4.3050700@esteem.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Jun 24, 2003 at 03:17:24PM -0700, Conn Clark wrote:
> 	I know that there is a cheap simple IDE interface for the MPC8xx
> 	family
> of processors that is supported in the kernel, I was wondering if
> someone has come up with a similar one for the IBM 405?

You have PCI on the 405, so you have a huge variety of cheap IDE
controllers that will work.  Look for some of the slightly older
Promise or CMD controllers from surplus suppliers, either should
work fine.

--Chris

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
