To: Dan Malek <dan@embeddededge.com>
Cc: Jean-Denis Boyer <jdboyer@mediatrix.com>,
	"'Pavel Bartusek'" <pba@sysgo.de>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: MDIO clock speed computation 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 22 Jul 2002 15:51:15 EDT."
             <3D3C6233.3090007@embeddededge.com>
Date: Mon, 22 Jul 2002 22:15:29 +0200
Message-Id: <20020722201534.F1B4910874@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3D3C6233.3090007@embeddededge.com> you wrote:
>
> system/bus clock speed.  Up to this point, I don't believe there are
> any 8xx parts that are qualified to run beyond a 50 MHz CPU/bus
> speed, so the software is just fine.  If you are running something
> faster than a 50 MHz bus, you may want to look into this.

There are. I've seen MPC823E, 860T, 860P and 862 qualified for 66 MHz
CPU/bus, and 862 for 100/50 MHz CPU/bus.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
They weren't that important. They were merely at the top. The  people
who  really  run organizations are usually found several levels down,
where it's still possible to get things done.
                                      - Terry Pratchett, _Small Gods_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
