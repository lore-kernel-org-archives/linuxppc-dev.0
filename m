Message-Id: <5.0.2.1.2.20040712121126.04ba4ea8@bhawley.mailhost.luminex.com>
Date: Mon, 12 Jul 2004 12:12:53 -0700
To: Wolfgang Denk <wd@denx.de>
From: Brian Hawley <bhawley@luminex.com>
Subject: Re: Suggestions for good IO embedded cpu 
Cc: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <20040709215108.5DC7DC109F@atlas.denx.de>
References: <Your message of "Fri, 09 Jul 2004 14:03:37 PDT." <5.0.2.1.2.20040709140134.06dc15a0@bhawley.mailhost.luminex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


We will have 4 optical tranceivers on one side.  PCI bus on the
other.  Essentially, the board will be a I/O processing engine, minimum of
17MB/sec on each
channel.  The PCI card will run under various flavors of unix and windows.

built in ports for serial and ethernet are nice, but not absolutely necessary.

If there are some other specifics requirement wise that you are needing,
please let me know.

-- Brian

At 11:51 PM 7/9/2004 +0200, Wolfgang Denk wrote:

>In message
><5.0.2.1.2.20040709140134.06dc15a0@bhawley.mailhost.luminex.com> you wrote:
> >
> > I'm seeking feedback from this experienced group on good choices for
> > embedded processors for
> > use in I/O intensive PCI cards.
>
>And what exactly are your requirements?
>
>Best regards,
>
>Wolfgang Denk
>
>--
>Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
>Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
>Thought for the day: What if there were no hypothetical situations?
>

+==========================================================+
Brian N. Hawley                 bhawley@luminex.com
Luminex Software, Inc.          http://www.luminex.com
PO Box 5908                     voice: 909-781-4100 x112
Riverside, CA  92517            fax: 909-781-4105
+==========================================================+


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
** This list is shutting down 7/24/2004.
