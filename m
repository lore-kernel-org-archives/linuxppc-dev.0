To: "Mark Chambers" <markc@mail.com>
Cc: "Matevz Langus" <matevz.langus@fortunal.net>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: JTAG debuggers for Motorola 8xx/82xx/85xx 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 09 Jun 2004 17:35:47 EDT."
             <007a01c44e69$bb7de860$0301a8c0@chuck2>
Date: Thu, 10 Jun 2004 00:38:05 +0200
Message-Id: <20040609223810.DB4B7C109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <007a01c44e69$bb7de860$0301a8c0@chuck2> you wrote:
>
> For 8xx, the open source BDM4GDB (which you can get from www.denx.de) is
> great.  I also partially ported the bdm driver to Windows for production
> testing work.  Under Windows, I've used CrossView (from Tasking.com) with
> Macraigor Wiggler (ocdemon.net) - all priced very reasonably.  However
> CrossView does not support linux (but BDM4GDB does, of course)

Note that the GDB in our ELDK not only supports the BDM4GDB, but also
the wiggler ...

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"You shouldn't make my toaster angry." - Household security explained
in "Johnny Quest"

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
