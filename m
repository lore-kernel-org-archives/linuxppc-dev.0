Message-ID: <3CA1E962.471968E8@mvista.com>
Date: Wed, 27 Mar 2002 10:46:42 -0500
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Michael Sokolov <msokolov@ivan.Harhan.ORG>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: EV-64260-BP & GT64260 bi_recs
References: <0203271732.AA04381@ivan.Harhan.ORG>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michael Sokolov wrote:

> Mark A. Greer <mgreer@mvista.com> wrote:
>
> > Forget the last one, here's attempt #3:
>
> I can live with this.

I like it too.

> But why is the MAC address in ASCII? Why not simply put the 6 bytes in there?
> Why the extra burden of parsing the ASCII?

Yes, it is ASCII.  I prefer the actual 6 bytes too but I know others have
expressed a strong preference for ASCII when dumping the bi_rec data (although
in this example the mac addr is just as easy to read in a hex dump).

Does anyone have a problem if the MAC address is changed to be binary?  Come to
think of it, since its of BI_DEV_TYPE_GT_ETH we can probably do what we want
since it only affects us.  Let'see if anyone comes up with a valid reason not to
change...

Mark


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
