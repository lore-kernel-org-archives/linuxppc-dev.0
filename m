To: Eugene Surovegin <ebs@ebshome.net>
Cc: Jeff Tucker <jeff@jltnet.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Need help booting linux on IBM 405EP eval board 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 02 Apr 2004 10:27:16 -0800."
             <20040402182716.GC8540@gate.ebshome.net>
Date: Fri, 02 Apr 2004 21:55:31 +0200
Message-Id: <20040402195536.E03D8C109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20040402182716.GC8540@gate.ebshome.net> you wrote:
>
> Standard bootloader which comes with 405ep eval board works fine with the Linux
> kernel, U-Boot - doesn't, and you are being told that it's not a U-Boot
> problem ?

It is not a problem that can be fixed in U-boot, as he must make sure
that Linux interptets the arguments passed by U-Boot correctly.

> So why don't you just use IBM bootloader and not U-Boot if you cannot get help
> from u-boot maillist?

He got help. Actually this is a FAQ.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Faith may be defined briefly as an illogical belief in the  occurence
of the improbable.                                    - H. L. Mencken

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
