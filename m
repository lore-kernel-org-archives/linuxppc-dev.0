To: "Linh Dang" <linhd@nortelnetworks.com>
Cc: "Embedded Linux PPC list" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: list of 2.6-related migration issues for embedded programmers? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 19 Jul 2004 21:38:27 EDT."
             <wn5zn5v8nl8.fsf@linhd-2.ca.nortel.com>
Date: Tue, 20 Jul 2004 09:16:05 +0200
Message-Id: <20040720071610.7BC31C109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <wn5zn5v8nl8.fsf@linhd-2.ca.nortel.com> you wrote:
>
>         - I failed to see what in initramfs mechanism would prevent
>           one from having "separated images which can be updated
>           independently of each other."

initramfs gets linked with the kernel into one image, similar to what
you got when building a zImage.initrd image.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
