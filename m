To: =?iso-8859-1?Q?=22Callebaut=2C_Beno=EEt=22?= <benoit.callebaut@barco.com>
Cc: "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: standalone boot problem with cramfs (kernel crash) 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 07 Mar 2003 10:46:43 +0100."
             <81A66F72DCACD511B0600002A551BFCB4E9D5F@kuumex05.barco.com>
Date: Fri, 07 Mar 2003 10:53:22 +0100
Message-Id: <20030307095327.72B5FC6E0C@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <81A66F72DCACD511B0600002A551BFCB4E9D5F@kuumex05.barco.com> you wrote:
>
> I enabled the cramfs, MTD(working), MTDBlock device
> disabled bootp,NFS.
> I changed the kernel  parameters root to /dev/mtdblock0
                                           ^^^^^^^^^^^^^^
> I use no initrd and the devfs support is enabled.
                          ^^^^^^^^^^^^^

I think /dev/mtdblock0 is not the  correct  device  name  when  using
devfs. For a test, disable devfs.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
The inappropriate cannot be beautiful.
             - Frank Lloyd Wright _The Future of Architecture_ (1953)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
