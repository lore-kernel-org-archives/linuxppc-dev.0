Subject: Re: Kernel panic: No init found.?? Try passing init= option to
	kernel
From: "Mike G." <gohas@actinium.org>
To: Mark Hatle <fray@mvista.com>
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <3F3AF502.2030300@mvista.com>
References: <1060827870.1060.20.camel@localhost.localdomain>
	 <3F3AF502.2030300@mvista.com>
Content-Type: text/plain
Message-Id: <1060829232.1060.24.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 14 Aug 2003 10:47:12 +0800
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Mark,

Thanks ... hmmm.. where can I get this ash.static.. is there a version
that runs on ppclinux?


> The way I usually debug this is to install ash.static on the system, set
> my kernel command line to have init=/bin/ash.static..  boot up and then
> attempt to run the "real" init manually so I can get the descriptive
> error messages.

--
Mike G. <gohas@actinium.org>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
