Message-ID: <67505026E29DD311A9AA00508B7315F350A526@EXCHANGE>
From: Julia Elbert <jelbert@enerdyne.com>
To: "'Dan Malek'" <dan@mvista.com>,
        "'linuxppc-embedded@lists.linuxppc.org'"
	 <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: switching linux kernels
Date: Tue, 26 Sep 2000 09:59:26 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Dan,
We don't need caching, can we turn it off?
Thanks.

		-----Original Message-----
		From:	Dan Malek [mailto:dan@mvista.com]
		Sent:	Tuesday, September 26, 2000 8:55 AM
		To:	Julia Elbert
		Cc:	'linuxppc-embedded@lists.linuxppc.org'
		Subject:	Re: switching linux kernels


		Julia Elbert wrote:

		>                 I am switching to HardHat 2.2.13 from ppc
2.2.13.

		> .....whatsoever, just the data is corrupted some how.


		Depending upon the flavor of the day ppc 2.2.13, it could be
a cache
		configuration difference.  The old 2.2.13 kernels often had
the data
		cache in the write-through mode to avoid a variety of bugs
in both
		hardware and software.

		The HHLinux 2.2.13 (and all later kernels) run with
copy-back data
		cache and subsequent silicon errata fixes, so there may be a
cache
		coherency hole in the way your driver manages it's space.


			-- Dan

		** Sent via the linuxppc-embedded mail list. See
http://lists.linuxppc.org/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
