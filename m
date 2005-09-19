Return-Path: <shawnxjin@gmail.com>
Received: from zproxy.gmail.com (zproxy.gmail.com [64.233.162.195])
	by ozlabs.org (Postfix) with ESMTP id 2BA37682DD
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 Sep 2005 04:40:06 +1000 (EST)
Received: by zproxy.gmail.com with SMTP id l1so691391nzf
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 19 Sep 2005 11:40:05 -0700 (PDT)
Message-ID: <c3d0340b050919114040d0a0fe@mail.gmail.com>
Date: Mon, 19 Sep 2005 11:40:05 -0700
From: Shawn Jin <shawnxjin@gmail.com>
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20050919153747.78ACC352682@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <200509191155.36540.david.jander@protonic.nl>
	<20050919153747.78ACC352682@atlas.denx.de>
Cc: David Jander <david.jander@protonic.nl>, linuxppc-embedded@ozlabs.org
Subject: Re: Which way to store log in flash on mpc8xx?
Reply-To: shawnxjin@gmail.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> > This must be a very common task (to store logfiles in flash), but I jus=
t can't
> > seem to find the right way to do it.
>=20
> Note that log files may cause a lot of trouble  when  using  a  JFFS2
> file  system. Youmay want to addd a buffering layer, like pramfs in a
> dedicated RAM area (SRAM ideally).

What's the trouble caused by log files when using a JFFS2? I'm not
aware of that. Any pointers to where I should look into are much
appreciated.

Best regards,
-Shawn.
