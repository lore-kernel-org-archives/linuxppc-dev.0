To: "Kevin A. Sapp" <Kevin.Sapp@catapult.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: RAM Disk problems 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 10 Mar 2004 09:31:01 EST."
             <404F26A5.7070807@catapult.com>
Date: Wed, 10 Mar 2004 16:00:27 +0100
Message-Id: <20040310150032.D3CBEC0655@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <404F26A5.7070807@catapult.com> you wrote:
>
> I am trying to bring up a RAM disk as the root file system.
> Most everything is working until it come's time to mount it.

This is an ext2 based ramdisk? Do you have ext2  support  enabled  in
your kernel? If yes, try disabling devfs.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
I mean, I . . . think to understand you, I just don't know  what  you
are saying ...                        - Terry Pratchett, _Soul Music_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
