Message-ID: <39D0C6C8.3091880B@mvista.com>
Date: Tue, 26 Sep 2000 11:54:48 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Julia Elbert <jelbert@enerdyne.com>
CC: "'linuxppc-embedded@lists.linuxppc.org'"
 <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: switching linux kernels
References: <67505026E29DD311A9AA00508B7315F350A522@EXCHANGE>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Julia Elbert wrote:

>                 I am switching to HardHat 2.2.13 from ppc 2.2.13.

> .....whatsoever, just the data is corrupted some how.


Depending upon the flavor of the day ppc 2.2.13, it could be a cache
configuration difference.  The old 2.2.13 kernels often had the data
cache in the write-through mode to avoid a variety of bugs in both
hardware and software.

The HHLinux 2.2.13 (and all later kernels) run with copy-back data
cache and subsequent silicon errata fixes, so there may be a cache
coherency hole in the way your driver manages it's space.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
