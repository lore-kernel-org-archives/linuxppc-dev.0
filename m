Subject: Re: getting support for command-line flash partitioning
From: David Woodhouse <dwmw2@infradead.org>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <Pine.LNX.4.60.0407011037010.15415@localhost.localdomain>
References: <Pine.LNX.4.60.0407011037010.15415@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1088695697.14216.3060.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Date: Thu, 01 Jul 2004 16:28:18 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 2004-07-01 at 10:45 -0400, Robert P. J. Day wrote:
>    so how is this being added to the files?  as in, who will add this
> feature to the individual files, and get it pushed upstream, if that's
> what's going to happen?  just curious as to how this feature will
> eventually end up in the mainstream.

The owner of each board support ('map') file is expected to make sure
that it's kept up to date in my CVS tree. Periodically I push updates to
Linus, although individuals are welcome to send their own changes to
Linus as soon as they're committed to CVS too.

--
dwmw2


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
