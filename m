Content-Type: text/plain;
  charset="iso-8859-1"
From: "Kevin B. Hendricks" <kevin.hendricks@sympatico.ca>
To: Wolfgang Denk <wd@denx.de>,
	"Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Subject: Re: fetch_and_add() available on PPC Linux?Hi,
Date: Thu, 6 Dec 2001 16:51:38 -0500
Cc: "Michael R. Zucca" <mrz5149@acm.org>,
	David Edelsohn <dje@watson.ibm.com>, linuxppc-dev@lists.linuxppc.org
References: <20011206150035.6BB10F9C1@denx.denx.de>
In-Reply-To: <20011206150035.6BB10F9C1@denx.denx.de>
MIME-Version: 1.0
Message-Id: <20011206214826.LYNR26909.tomts15-srv.bellnexxia.net@there>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

On December 6, 2001 10:00, Wolfgang Denk wrote:
> In message <20011206140445.TQHJ17034.tomts10-srv.bellnexxia.net@there>
you wrote:
> > I think it is the same as the cache line size (32 bytes for most ppc
> > machines but defintely that cache line size changes for some
> > implementations (so go with at least 32 bytes and you should be safe).
>
> ...except on embedded CPUs like MPC8xx which have a cache  line  size
> of only 16 bytes

So 32 bytes apart is fine.  That will make it two cache line sizes on your
machine so that more than meets the min lock granularity.

Kevin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
