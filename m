Message-ID: <F9102D41F595D311ACA7009027DE2C840527B5BA@c3po.heurikon.com>
From: "Johnson, Stephen" <stevebj@artesyncp.com>
To: "'Dan Kegel'" <dank@kegel.com>,
	emanuel stiebler <emu@ecubics.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: ELDK 2.1.0, kernel 2.4.21, MPC8245, ntpd
Date: Tue, 19 Aug 2003 14:38:08 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Is ntpd trying to update your RTC out on i2c in interrupt context?



-----Original Message-----
From: Dan Kegel [mailto:dank@kegel.com]
Sent: Tuesday, August 19, 2003 2:10 PM
To: emanuel stiebler
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: ELDK 2.1.0, kernel 2.4.21, MPC8245, ntpd



emanuel stiebler wrote:
> I get a "Segmentation fault (core dumped)" on my system using ntpd.
> I checked the archives, and there is one messeage about something like
> this on a 405.
>
> Is anybody working on this ? Did I missed some patches ?

No idea, but if you're using ELDK binaries, you might check
with their mailing list.

And then there's always compiling ntpd yourself and running
it under gdb or gdbserver to see where it's crashing...
- Dan

--
Dan Kegel
http://www.kegel.com
http://counter.li.org/cgi-bin/runscript/display-person.cgi?user=78045


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
