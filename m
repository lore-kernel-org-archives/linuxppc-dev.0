Date: Thu, 1 Jul 2004 12:48:30 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: getting support for command-line flash partitioning
In-Reply-To: <1088695697.14216.3060.camel@hades.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.60.0407011244070.16076@localhost.localdomain>
References: <Pine.LNX.4.60.0407011037010.15415@localhost.localdomain>
 <1088695697.14216.3060.camel@hades.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 1 Jul 2004, David Woodhouse wrote:

> On Thu, 2004-07-01 at 10:45 -0400, Robert P. J. Day wrote:
>>    so how is this being added to the files?  as in, who will add this
>> feature to the individual files, and get it pushed upstream, if that's
>> what's going to happen?  just curious as to how this feature will
>> eventually end up in the mainstream.
>
> The owner of each board support ('map') file is expected to make sure
> that it's kept up to date in my CVS tree. Periodically I push updates to
> Linus, although individuals are welcome to send their own changes to
> Linus as soon as they're committed to CVS too.

ok, i was just trying to figure out how the different versions of the
kernel i have have such differing levels of that CMDLINE support.

the original kernel tree i have from embedded planet (approx. 2.4.22)
has a small number of map files that make any reference to that
feature.  the CVS tree from denx (2.4.25) has considerably more.  and
neither the latest "bk pull" of the 2.5/2.6 kernel from bkbits.net, or
the standard 2.6 kernel on my fedora core system has *any* support for
that feature in the map files (even though the kernel has the internal
support).

i was just trying to figure out the logical flow of how that feature
worked its way in.  thanks.

rday

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
