To: David Woodhouse <dwmw2@infradead.org>
Cc: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: 2.4 versus 2.6 patches 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 26 Jul 2004 10:27:52 EDT."
             <Pine.LNX.4.58.0407261021120.6190@localhost.localdomain>
Date: Mon, 26 Jul 2004 19:16:03 +0200
Message-Id: <20040726171608.12880C109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <Pine.LNX.4.58.0407261021120.6190@localhost.localdomain> you wrote:
>
> Deployment if you're already almost ready to ship is sane enough, I
> suppose -- but to actually put more effort into 2.4 wouldn't make much
> sense.

It depends on your requirements.

If you need a kernel that is
	(1) stable and working [2.6 is still pretty much useless for  example
	    on  8xx  systems],
	(2) small [2.6 is usually >= 20% bigger than 2.4],
and/or
	(3) fast [2.6 is usually >= 10% slower than 2.4],
then 2.4 may be the better choice.

> Because nobody's really that interested in it. For what it's worth, I've
> abandoned all pretence of continuing to support 2.4 in the MTD/JFFS2 CVS

David, you can do what you want. But it is not up to  you  to  decide
what  other people are doing. I declare that there ARE people who are
interested in 2.4 kernel - both for maintenance and development work.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Another megabytes the dust.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
