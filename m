To: "James Dougherty" <jfd@broadcom.com>
Cc: "bhupinder sahran" <bhup_sah@yahoo.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Problems with mount system call -- cannot mount procfs! 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 31 Jul 2002 12:03:04 PDT."
             <3D483468.CB6DAE54@broadcom.com>
Date: Wed, 31 Jul 2002 21:49:02 +0200
Message-Id: <20020731194907.0224D1087A@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3D483468.CB6DAE54@broadcom.com> you wrote:
>
> I checked out my ppcboot early_init.S and the ppcboot startup files.
> In ppcboot-1.1.4/cpu/mpc824x/start.S
...
> I remove this code with an ifdef:
>
> #if !defined(CONFIG_MUSENKI) && !defined(CONFIG_BMW)
>
> And then rebuilt and boot linux-2.4.19-rc3 (latest rsync from mvista.com yesterday)!

Well, and what was the result?

> Does the setup code above work on Sandpoint, or another MPC824x system?

Sure. It works here on SP8240, and on CU824 boards (both with 8240 CPUs).

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
All I ask is a chance to prove that money can't make me happy.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
