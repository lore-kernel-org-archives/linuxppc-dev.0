Message-ID: <3F4571C4.4090900@kegel.com>
Date: Thu, 21 Aug 2003 18:28:36 -0700
From: Dan Kegel <dank@kegel.com>
MIME-Version: 1.0
To: Mark Hatle <fray@mvista.com>
Cc: C Doyle <cdoyle35@hotmail.com>,
	libusb-devel@lists.sourceforge.net,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: libusb harhat/eldk cross-compile problems
References: <Law10-F1011bpqRbwXQ0004bf26@hotmail.com> <3F452F86.2050004@mvista.com>
In-Reply-To: <3F452F86.2050004@mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Mark Hatle wrote:
> C Doyle wrote:
>>    I'm trying to get the libusb to cross compile ...
>>
>> checking size of char... configure: error: can not run test program while
>> cross compiling
>
> You will need to override the configure step for figuring out things via
> compilation and running.
>
> You will need to look at the configure script and see if you can
> override the sizeof char.  (Similarly to how you overrode
> ac_cv_func_setvbuf_reversed on the command line.)
>
> If that is not possible, you will have to hack "configure" with the hard
> coded value.  (To do it "right" you should modify configure.in, then run
> autoconf.  However, that doesn't always work.)

Also, that particular problem is solved by newer versions
of autoconf, so in the best of all possible worlds, you
just need to have autoconf-2.53 or later installed,
and type
   autoconf
before running configure.   That only works sometimes, though,
since configure.in sometimes needs to be fixed a little bit to
work with the new autoconf.
- Dan


--
Dan Kegel
http://www.kegel.com
http://counter.li.org/cgi-bin/runscript/display-person.cgi?user=78045


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
