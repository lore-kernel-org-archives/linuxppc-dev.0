Mime-Version: 1.0
Message-Id: <v04220801b75d46b6cf71@[10.0.0.42]>
In-Reply-To: <3B36F1B3.BFC12A3B@student.ethz.ch>
References: <3B36F1B3.BFC12A3B@student.ethz.ch>
Date: Mon, 25 Jun 2001 12:53:14 -0700
To: Luc Knoepfli <luck@student.ethz.ch>,
	LinuxDev <linuxppc-dev@lists.linuxppc.org>
From: "Timothy A. Seufert" <tas@mindspring.com>
Subject: Re: G4 upgrade cards and oldworld mac's, BootX
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 10:09 AM +0200 6/25/01, Luc Knoepfli wrote:

>Second question.
>Under MacOS the AltiVec unit has to be enabled by software (INIT), is
>this done by the kernel under Linux?

Just compile the kernel with AltiVec support turned on.

Then, you're going to need AltiVec-using software, which there isn't
very much of on Linux...

   Tim Seufert

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
