Date: Wed, 27 Sep 2000 21:18:27 +0200 (CEST)
From: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
To: R Shapiro <rshapiro@bbn.com>
cc: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        daenzerm@student.ethz.ch, linuxppc-dev@lists.linuxppc.org
Subject: Re: xf 4.0.1 + ati driver with rage II/rage pro
In-Reply-To: <14802.18291.902553.42491@esb.bbn.com>
Message-ID: <Pine.LNX.4.10.10009272117210.10201-100000@zirkon.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>  > S**t. I overlooked that. Ok, I officially declare the ati driver unable to
>  > cope.
>
> Just to mention: the ati driver *does* work on my other G3, a
> single-monitor rev. b Rage Pro running the same XFree 4.0.1 (different

Unable to cope with multiple framebuffers :-) Single framebuffer is easy:
PCI and fb should address the same card.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
