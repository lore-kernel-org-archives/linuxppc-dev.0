Reply-To: <zjzhou@newrocktech.com>
From: "John Zhou" <zjzhou@newrocktech.com>
To: "'Jaap-Jan Boor'" <jjboor@aimsys.nl>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: display top CPU processes top tool
Date: Fri, 5 Sep 2003 17:23:24 +0800
Message-ID: <000201c3738f$5bcfd2d0$9702a8c0@newrock2>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-reply-to: <AC6519E7-DF7F-11D7-B7DD-003065E2BB06@aimsys.nl>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Yes. I have a /etc/TERMCAP. But it's still failed. need other changes ?

Thanks for your email.

-----Original Message-----
From: owner-linuxppc-embedded@lists.linuxppc.org
[mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Jaap-Jan
Boor
Sent: Friday, September 05, 2003 5:02 PM
To: zjzhou@newrocktech.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: display top CPU processes top tool



Do you have a /etc/TERMCAP ?

On vrijdag, sep 5, 2003, at 10:26 Europe/Amsterdam, John Zhou wrote:

>
> Hi, all
>
> I'm using "top" tool to display top CPU processes and system running
> information in my Embedded Linux based on PowerPC. But, when I run
> "top" command in prompt #, it's coming on:
>
> # set
> PS2=>
> PS1=#
> IFS=
> USER=root
> SHELL=/bin/sh
> PATH=/usr/bin:/bin:/usr/sbin:/sbin
> HOME=/
> TERM=ansi
> #
> # top
> top: Unknown terminal "ansi" in $TERM
> #
>
> I changed to :
>
> # export TERM=VT100
> # set
> PS2=>
> PS1=#
> IFS=
> USER=root
> SHELL=/bin/sh
> PATH=/usr/bin:/bin:/usr/sbin:/sbin
> HOME=/
> TERM=VT100
> # top
> top: Unknown terminal "VT100" in $TERM
> #
>
> Another question:
>
> How to use "top" with option to save cpu information to a log file?
>
> Thanks for any help.
>
> John Zhou
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
