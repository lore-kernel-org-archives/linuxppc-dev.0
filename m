Date: Mon, 14 Jul 2003 07:52:01 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Dean Matsen <deanm@earthlink.net>
Cc: Paul Mackerras <paulus@samba.org>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Ethernet PHY chip discovery not working on 855T with 971/972 chips
Message-ID: <20030714145200.GC1211@ip68-0-152-218.tc.ph.cox.net>
References: <3F0C8112.5060001@earthlink.net> <20030709212145.49E24C6D82@atlas.denx.de> <20030711151834.GU17433@ip68-0-152-218.tc.ph.cox.net> <3F0F468F.1050909@earthlink.net> <16143.24034.31805.589402@cargo.ozlabs.ibm.com> <3F1079FA.3050901@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3F1079FA.3050901@earthlink.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Sat, Jul 12, 2003 at 02:13:30PM -0700, Dean Matsen wrote:

> Paul Mackerras wrote:
>
> >Dean Matsen writes:
> >
> >
> >
> >>Somewhere in this discussion thread I saw that the 2.4 kernel is closed
> >>for
> >>patches (I just joined this list, so I didn't know that).
> >>
> >>
> >
> >Well, that's not strictly true, we will continue to fix things that
> >are broken, but I would prefer than any new development (e.g. support
> >for new boards or devices) happened in 2.5.  It's a bit disappointing
> >that 8xx still doesn't compile in 2.5.  I don't have any 8xx hardware
> >to test on so I have been relying on others to update it.
> >
> >
> Ok, in that case I do have ONE thing that I know should be fixed, but
> I haven't seen any response on it, so I am wondering if anyone noticed
> it at all. See
>
> http://lists.linuxppc.org/linuxppc-dev/200307/msg00085.html

This has been fixed in the 2_4_devel tree now.  This is not an issue in
2.5 / 2.6.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
