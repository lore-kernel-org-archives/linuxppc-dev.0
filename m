From: Paul Mackerras <paulus@linuxcare.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14729.3700.660339.484633@argo.linuxcare.com.au>
Date: Thu, 3 Aug 2000 16:17:24 +1000 (EST)
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: keyboard problems
In-Reply-To: <news2mail-8m5oaq$6tj$3@mate.bln.innominate.de>
References: <news2mail-8m5oaq$6tj$3@mate.bln.innominate.de>
Reply-To: paulus@linuxcare.com.au
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Thomas Graichen writes:
>
> i have a little keyboard problem on my blueberry imac with the
> standard usb keyboard: whenever i type something very quickly
> followed by space the typed in will be repeated before the
> space (best example: i want to type "cd " and get "cdcd ")
> - this gets a bit annoying - does anybody have the same
> problem (or even a fix for it) ? - is it more a soft-
> wareproblem (i hope :-) or maybe a hardwareproblem ?
> (i had it on all kernels from 2.2.x to 2.4.0-testx)

It's simply a bug in the USB keyboard driver.  It just means that the
driver isn't coping with the "overflow" code that the keyboard sends
when it has too many keys depressed at once.

--
Paul Mackerras, Senior Open Source Researcher, Linuxcare, Inc.
+61 2 6262 8990 tel, +61 2 6262 8991 fax
paulus@linuxcare.com.au, http://www.linuxcare.com.au/
Linuxcare.  Support for the revolution.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
