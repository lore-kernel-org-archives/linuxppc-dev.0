Message-ID: <3F3AFD72.9030206@mvista.com>
Date: Wed, 13 Aug 2003 22:09:38 -0500
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: "Mike G." <gohas@actinium.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Kernel panic: No init found.?? Try passing init= option to	kernel
References: <1060827870.1060.20.camel@localhost.localdomain>	 <3F3AF502.2030300@mvista.com> <1060829232.1060.24.camel@localhost.localdomain>
In-Reply-To: <1060829232.1060.24.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Find your favorite embedded distro.. if it doesn't contain it, you'll
have to build one.

The debian project is the home of ash for Linux..
(ftp.debian.org/debian/pool/main/a/ash   if I remember right)

--Mark

Mike G. wrote:
> Hi Mark,
>
> Thanks ... hmmm.. where can I get this ash.static.. is there a version
> that runs on ppclinux?
>
>
>
>>The way I usually debug this is to install ash.static on the system, set
>>my kernel command line to have init=/bin/ash.static..  boot up and then
>>attempt to run the "real" init manually so I can get the descriptive
>>error messages.
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
