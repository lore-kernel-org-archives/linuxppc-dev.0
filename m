Message-ID: <67505026E29DD311A9AA00508B7315F350A527@EXCHANGE>
From: Julia Elbert <jelbert@enerdyne.com>
To: "'linuxppc-embedded@lists.linuxppc.org'"
	 <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: switching linux kernels
Date: Tue, 26 Sep 2000 11:24:39 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thanks Dan and Graham.
I am in the process of switching to 2.2.14. But, just for your knowledge, my
bug was fixed by turning off the Copy-Back Data Cache fixed my problem.
Now, back to my move to 2.2.14.
Thank you again,
Julia

		-----Original Message-----
		From:	Julia Elbert [mailto:jelbert@enerdyne.com]
		Sent:	Tuesday, September 26, 2000 9:59 AM
		To:	'Dan Malek'; 'linuxppc-embedded@lists.linuxppc.org'
		Subject:	RE: switching linux kernels


		Hi Dan,
		We don't need caching, can we turn it off?
		Thanks.

				-----Original Message-----
				From:	Dan Malek [mailto:dan@mvista.com]
				Sent:	Tuesday, September 26, 2000 8:55 AM
				To:	Julia Elbert
				Cc:
'linuxppc-embedded@lists.linuxppc.org'
				Subject:	Re: switching linux kernels


				Julia Elbert wrote:

				>                 I am switching to HardHat
2.2.13 from ppc
		2.2.13.

				> .....whatsoever, just the data is
corrupted some how.


				Depending upon the flavor of the day ppc
2.2.13, it could be
		a cache
				configuration difference.  The old 2.2.13
kernels often had
		the data
				cache in the write-through mode to avoid a
variety of bugs
		in both
				hardware and software.

				The HHLinux 2.2.13 (and all later kernels)
run with
		copy-back data
				cache and subsequent silicon errata fixes,
so there may be a
		cache
				coherency hole in the way your driver
manages it's space.


					-- Dan

				** Sent via the linuxppc-embedded mail list.
See
		http://lists.linuxppc.org/

		** Sent via the linuxppc-embedded mail list. See
http://lists.linuxppc.org/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
