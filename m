From: Remco Treffkorn <remco@rvt.com>
Reply-To: remco@rvt.com
To: Brice Figureau <brice@tincell.com>
Subject: Re: ibook2r2 & strange freeze.
Date: Fri, 25 Apr 2003 13:12:37 -0700
References: <1051284468.2467.179.camel@localhost.localdomain>
In-Reply-To: <1051284468.2467.179.camel@localhost.localdomain>
Cc: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200304251312.37645.remco@rvt.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Friday 25 April 2003 08:27, Brice Figureau wrote:
...
> I then commented-out this part of rc.sysinit and then I could boot up to
> the login prompt.

Seems to me you have more than one problem. I have trouble with CONFIG_RTC
set. Hwclock will hang in rc.sysinit. Try configuring without RTC.

Cheers,
Remco

--
Remco Treffkorn (RT445)
HAM DC2XT
remco@rvt.com   (831) 685-1201

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
