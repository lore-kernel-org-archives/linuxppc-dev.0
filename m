Date: Thu, 28 Aug 2003 21:31:25 +0200
From: Magnus Damm <damm@opensource.se>
To: Lokesh Kumar <lokesh.kumar@wrx-us.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: mic2563 dual slot pcmcia controller
Message-Id: <20030828213125.4aa3577b.damm@opensource.se>
In-Reply-To: <3439AB3A99ECD5409F3A52ACF814744D158D6F@norcom2.norcom.net>
References: <3439AB3A99ECD5409F3A52ACF814744D158D6F@norcom2.norcom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello there,

> I have a mpc8xx based board, which has two pcmcia slots, and uses micrel
> 2563a power controller. Now, I understand that I have to control this in the
> file drivers/pcmcia/m8xx_setup.c file. I was wondering if anybody has done
> the same and can tell me what is the right way. Also, where do I set the
> other pcmcia related values for example pbr0, memory size etc? Any pointers
> would be helpful.

Yes, the power controller code is board specific. I don't remember much of
it today, but I don't think I've used a power controller like that.
The pcmcia related registers like pbr0 are setup by the m8xx_setup.c-code
dynamically, so there should be no need to mess with registers like that.
Please note that the pcmcia hardware in the m8xx series is kind of limited
if you use it with two slots, see the source code for more info.

Hope this helps!

/ magnus

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
