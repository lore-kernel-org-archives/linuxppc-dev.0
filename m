Date: Mon, 4 Feb 2002 14:25:03 -0600
From: Dave Wolfe <dwolfe@lists.linuxppc.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Correct way to submit a patch?
Message-ID: <20020204142503.A20449@lists.linuxppc.org>
References: <3C5E3B8F.5060105@elsoft.ch> <20020204004850.24542@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020204004850.24542@mailhost.mipsys.com>; from benh@kernel.crashing.org on Mon, Feb 04, 2002 at 01:48:49AM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


[ benh@kernel.crashing.org writes: ]
>
> The proper way is to send it to this list, eventually CC'ed to one
> of the people in the MAINTAINERS file depending which type of machine
> is affected by it.

I would suggest that patches be attached to the email. Attachments
can be easily saved off as files, whereas inlined patches must be
extracted from the rest of the message and often get mangled by MUAs.
This is particularly true when trying to retrieve patches from the HTML
archives. Ideally such attachments would also be encoded or use some
other means to prevent them from being mangled during mail transport.

Also note that once you hit 20 or 30 Kb, it's not a patch, so please
don't try to send it to the list. Put it on an FTP or web server and
mail the URL to the list, or mail it privately to the maintainers.

--
 Dave Wolfe

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
