Date: Fri, 5 Sep 2003 11:02:27 +0200
Subject: Re: display top CPU processes top tool
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v552)
Cc: <linuxppc-embedded@lists.linuxppc.org>
To: <zjzhou@newrocktech.com>
From: Jaap-Jan Boor <jjboor@aimsys.nl>
In-Reply-To: <000001c37387$5897abe0$9702a8c0@newrock2>
Message-Id: <AC6519E7-DF7F-11D7-B7DD-003065E2BB06@aimsys.nl>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


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
