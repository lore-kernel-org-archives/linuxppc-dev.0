To: Jan Damborsky <jan.damborsky@devcom.cz>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Ethernets on SCC2 and SCC3 on mpc8xx 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 13 Aug 2003 15:33:32 +0200."
             <3F3A3E2C.8040609@devcom.cz>
Date: Wed, 13 Aug 2003 18:47:22 +0200
Message-Id: <20030813164727.97DFBC59E4@atlas.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,

in message <3F3A3E2C.8040609@devcom.cz> you wrote:
>
> we want to use our custom board with MPC823e as
> easy firewall in our applications. We have two 10Mbit ethernet
> on board connected to SCC2 and SCC3 channels.
> Is it support in kernel
> for using both SCC channels configured as ethernet
> (eth0, eth1 devices) simultaneously ? I use 2.4.3 kernel

No, none of the public kernels supprts such  a  configurations.  Some
(ugly) patches (basicly duplicating the whole code) habe beeen posted
a  long,  long  time  ago.  You might find them in the archies. But a
rework of the driver shouldn't be oo difficult.


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
What was sliced bread the greatest thing since?

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
