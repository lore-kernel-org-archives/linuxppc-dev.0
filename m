To: "AlessandroPPC" <aleppcrossi@libero.it>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: self image 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 10 Dec 2003 12:09:33 +0100."
             <004f01c3bf0e$1839e2c0$0400a8c0@eurostudio.local>
Date: Wed, 10 Dec 2003 22:06:02 +0100
Message-Id: <20031210210608.03D20C5F5F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Alessandro,

in message <004f01c3bf0e$1839e2c0$0400a8c0@eurostudio.local> you wrote:
>
> I'm just looking at the SELF image and I observed that when I extract the
> image and try to rebuild it
> (without adding or removing any files) the dimension of result file is about
> 9KByte greater  than the original.
> I have followed the procedure "How to increase the Size of ramdisk" to
> generate an 8MByte ramdisk thus I
> was expecting a small increase of the bytes amount, but never as reported.
> Do you think I'm wrong somewhere?

Your new filesystem is twice as big as the old one, so it  will  have
more inode blocks etc. Also, you may notice that our filesystem image
does not contain the (rather large) lost+found firectory.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Death. Destruction. Disease. Horror. That's what war  is  all  about.
That's what makes it a thing to be avoided.
	-- Kirk, "A Taste of Armageddon", stardate 3193.0

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
