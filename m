Message-ID: <19991127233137.24145.rocketmail@web1004.mail.yahoo.com>
Date: Sat, 27 Nov 1999 15:31:37 -0800 (PST)
From: Dan Bethe <dan_bethe@yahoo.com>
Subject: Re: missing atyfb option in kernel 2.2.14pre9
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


	I would appreciate it if the members of the list
would answer the following issue in detail, because
I'm intending to organize all Powerbook documentation
for www.linuxppc.org.  Thanks!

--- Michael <michael.fenske@arcormail.de> wrote:
> 
> If I do 'make menuconfig' with the source from
> linuxcare.com.au version
> 2.2.14pre9, I can't select the atyfb driver, because
> there is no option
> for this driver. Who has stolen this option ;-)

	I second that question, from a slightly different
angle.  I have been collecting the kernel source from
mirrors of the official kernel.org.  I get mine from
the SunSITE mirror on ftp.cdrom.com.  When I do either
'make menuconfig' or 'make xconfig', I notice that
under the "console" section, there are two entries for
"ATI Mach 64".  They are both identical, they're both
selected, and I cannot change their selections!
	This has been true with kernel versions 2.2.10,
2.2.12, 2.2.13, and 2.3.22.
	I have a Powerbook G3 Wallstreet series (May 1998)
and all development environment is from my stock
LinuxPPC R5 (not Q3) distribution.  Is it imperative
for me to upgrade to Q3?  I can do that.
	Thank you!

=====
"Don't expect your own messiah; this neverworld which you desire is
only in your mind." -- http://www.dreamtheater.net/songb4.htm#IV5
Thousands of Stores.  Millions of Products.  All in one place.
Yahoo! Shopping: http://shopping.yahoo.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
