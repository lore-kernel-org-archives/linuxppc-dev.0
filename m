Message-ID: <398AE12A.523F3CFE@ivey.uwo.ca>
Date: Fri, 04 Aug 2000 11:28:42 -0400
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
MIME-Version: 1.0
To: David Edelsohn <dje@watson.ibm.com>
CC: Gabriel Paubert <paubert@iram.es>, Takashi Oe <toe@unlserve.unl.edu>,
        Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
        Thomas Graichen <graichen@innominate.de>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: shifts on 64bit ints
References: <200008041518.LAA25218@mal-ach.watson.ibm.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

But if they are not cc'd to the linuxppc-dev list then we do need some sort of
CHANGELOG process going on.  None of the rsync trees seem to do any versioning.

Possibly we should have our own kernel mailing lists for patches and things.

Kevin

David Edelsohn wrote:
>
> >>>>> Gabriel Paubert writes:
>
> Gabriel> I plan to send a lot of small obvious bugfixes in the next 3-4 weeks, the
> Gabriel> diffs between  my tree and the official one now run in the megabyte range,
> Gabriel> and this is too much (would the BitKeeper tree accept the VME patches and
> Gabriel> PrePboot BTW ?)
>
> Gabriel> What I would for one like to see is that people that write a patch that
> Gabriel> may affect other machines than their own first publish it on this list and
> Gabriel> wait a couple of days for comment and test results before pushing it to
> Gabriel> the official source tree, somewhat like what happens on gcc-patches.
>
>         linuxppc-dev is not necessarily a patch submission mailinglist.
> Until PowerPC Linux development has such a thing, I think that it is
> better to coordinate with and directly send patches to someone with
> write-access who can apply the patches instead of throwing them up in the
> air and hoping that someone catches them.
>
> David
>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
