To: Rod Boyce <rod_boyce@stratexnet.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Creating RAM disks as a non root user. 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 04 Feb 2003 15:00:57 +1300."
             <8D7C5F56B409554D9D46AC22195807F3061C5B@exchwenz01.dmcwave.co.nz>
Date: Tue, 04 Feb 2003 03:14:37 +0100
Message-Id: <20030204021442.38638C608E@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <8D7C5F56B409554D9D46AC22195807F3061C5B@exchwenz01.dmcwave.co.nz> you wrote:
>
> I've got to create a RAM disk for our new system.  I've found this little
> utility called genext2fs the web site is
> http://sourceforge.net/projects/genext2fs/
> <http://sourceforge.net/projects/genext2fs/>  but my question.
> What do other people use to do this? Why should I have to become the root

Our ELDK uses genext2fs, too.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Landru! Guide us!
	-- A Beta 3-oid, "The Return of the Archons", stardate 3157.4

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
