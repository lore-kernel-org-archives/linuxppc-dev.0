From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15430.9343.253673.511765@argo.ozlabs.ibm.com>
Date: Thu, 17 Jan 2002 12:10:23 +1100 (EST)
To: Larry McVoy <lm@bitmover.com>
Cc: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Problems with linuxppc_2_4_devel
In-Reply-To: <20020115130203.K15959@work.bitmover.com>
References: <20020115162546.GB764@cpe-24-221-152-185.az.sprintbbd.net>
	<Pine.LNX.4.33.0201151756200.11139-100000@gra-lx1.iram.es>
	<20020115112233.E15959@work.bitmover.com>
	<20020115205755.GF764@cpe-24-221-152-185.az.sprintbbd.net>
	<20020115130203.K15959@work.bitmover.com>
Reply-To: paulus@samba.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Larry McVoy writes:

> What I was thinking was one of two approaches:
>
> a) try and connect to a well known time server and see if the time is too
>    far off at commit time.  May or may not work.

Are you talking about doing this just on ppc.bkbits.net or on
everybody's repository clone as well?  I think it would be an
excellent idea for ppc.bkbits.net to reject changesets whose time is
after the current time.  I don't think we want to make everybody's
clones do that though.

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
