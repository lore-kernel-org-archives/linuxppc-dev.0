Mime-Version: 1.0
Message-Id: <v04220801b5e7574c37ed@[10.0.0.42]>
In-Reply-To: <39C092E3.89821701@cisco.com>
References: <39C092E3.89821701@cisco.com>
Date: Thu, 14 Sep 2000 21:38:23 -0700
To: mnorton@cisco.com, linuxppc-dev@lists.linuxppc.org
From: "Timothy A. Seufert" <tas@mindspring.com>
Subject: Re: Speech Recogniton
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 4:57 AM -0400 9/14/00, Michael Norton wrote:
>hi,
>
>Do any libraries exist that allow me to use the Apple Speech recognition
>hardware under LinuxPPC?

Sorry, there is no hardware (aside from a simple digitizer to capture
the sound of course).  Apple's speech recognition is 100% software.

The original implementation on 68K Macs used an AT&T DSP coprocessor
to do the crunching because the 68K didn't have enough oomph to do it
by itself, but the PowerPC implementation relies on nothing but the
CPU.

   Tim Seufert

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
