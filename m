From: acmay@acmay.homeip.net
Date: Sat, 25 Aug 2001 00:35:47 -0700
To: Dan Malek <dan@mvista.com>
Cc: andrew may <acmay@acmay.homeip.net>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: get_cycles/get_tbl on 405
Message-ID: <20010825003547.J1165@sink.san.rr.com>
References: <20010823185911.A3291@ecam.san.rr.com> <3B870EDE.711669EB@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3B870EDE.711669EB@mvista.com>; from dan@mvista.com on Fri, Aug 24, 2001 at 10:35:10PM -0400
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Aug 24, 2001 at 10:35:10PM -0400, Dan Malek wrote:
> andrew may wrote:
> >
> > I wanted to do some quick time measurements of some things on a driver
> > running of the 405GP and I eneded up using get_tbl(). It seems like
> > get_cycles....
>
> Hmmm....these look like they should work exactly the same.....
> It would help me if you could disassemble a little code snippet
> around the place you use these so we could have a look.

They did. I just confused myself with too many kernel versions.
The 2.4.2 mvista kernel didn't have the same header file, but by
just sticking the newer header in there with the one other header
it pulls in along with it, it worked fine.

The __ftr_fixup doesn't seem to be used much in any of the other
arch's.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
