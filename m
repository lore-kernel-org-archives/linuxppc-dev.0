Message-Id: <200008041518.LAA25218@mal-ach.watson.ibm.com>
To: Gabriel Paubert <paubert@iram.es>
cc: Takashi Oe <toe@unlserve.unl.edu>,
        Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
        Thomas Graichen <graichen@innominate.de>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: shifts on 64bit ints 
In-Reply-To: Message from Gabriel Paubert <paubert@iram.es>
   of "Fri, 04 Aug 2000 11:21:08 +0200." <Pine.HPX.4.10.10008041100270.9070-100000@gra-ux1.iram.es>
Date: Fri, 04 Aug 2000 11:18:28 -0400
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> Gabriel Paubert writes:

Gabriel> I plan to send a lot of small obvious bugfixes in the next 3-4 weeks, the
Gabriel> diffs between  my tree and the official one now run in the megabyte range,
Gabriel> and this is too much (would the BitKeeper tree accept the VME patches and
Gabriel> PrePboot BTW ?)

Gabriel> What I would for one like to see is that people that write a patch that
Gabriel> may affect other machines than their own first publish it on this list and
Gabriel> wait a couple of days for comment and test results before pushing it to
Gabriel> the official source tree, somewhat like what happens on gcc-patches.

	linuxppc-dev is not necessarily a patch submission mailinglist.
Until PowerPC Linux development has such a thing, I think that it is
better to coordinate with and directly send patches to someone with
write-access who can apply the patches instead of throwing them up in the
air and hoping that someone catches them.

David


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
