Date: Sun, 18 Jan 2004 21:47:51 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Jacky Lam <jackylam@astri.org>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Small UDP packet performance
Message-ID: <20040119054751.GB26841@gate.ebshome.net>
References: <00b101c3de3e$9c34f200$9104050a@JACKYLAM> <20040119052806.GA26841@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040119052806.GA26841@gate.ebshome.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Sun, Jan 18, 2004 at 09:28:06PM -0800, Eugene Surovegin wrote:
> Let's say you box is fast enough to send 10K packets per second. As
> you see it's more than enough to saturate 100Mb Ethernet with big
> packets (UDP payload > ~1120 bytes).
>
> But with 200-sized UDP payload you can only fill ~2.7% of 100Mb link.
>

grr, it's 21% of 100Mb link (16% effective (without overhead)).

Eugene.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
