To: David Woodhouse <dwmw2@infradead.org>
Cc: "Robert P. J. Day" <rpjday@mindspring.com>,
	Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: loading the kernel and root FS separately from flash? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 28 Jun 2004 10:42:34 BST."
             <1088415754.6992.1.camel@hades.cambridge.redhat.com>
Date: Mon, 28 Jun 2004 12:36:25 +0200
Message-Id: <20040628103630.D1709C109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <1088415754.6992.1.camel@hades.cambridge.redhat.com> you wrote:
>
> I think it should be OK when it's 4MiB in size. Mount time was far more
> of a problem in JFFS2 many years ago when people were using the 2.4
> kernel. It's a lot faster in 2.6.

Is this really a question of which  kernel  is  running?  It  was  my
impression that this is merely an issue of which version of the JFFS2
(i. e. MTD) code you are using?

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
panic: kernel trap (ignored)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
