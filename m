To: "Aman" <aman@mistralsoftware.com>
Cc: "linuxppc embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: NFS Mount 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 09 Sep 2002 22:03:52 +0530."
             <007001c2581e$af4a9900$370da8c0@aman>
Date: Mon, 09 Sep 2002 18:50:09 +0200
Message-Id: <20020909165014.E517EFA8B@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Aman,

in message <007001c2581e$af4a9900$370da8c0@aman> you wrote:
>
> My root path in the dhcpd.conf  is /hdb/mydir/mykernel , this where I have
> un tar the linux kernel source for PPC.

This is wrong. You have use a directory which contains  a  filesystem
with native tools, dev entries, libraries, etc.

> My doubt is , will there be a filesystem already in the linux source at the
> location /hdb/mydir/mykernel or I have to create it. If I have create it,

The linux kernel source is just that: kernbel source. It does not contain a root filesystem.

> how should I go about.

Get and install our ELDK. It's free. See
http://www.denx.de/re/ELDK.html

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"I didn't know it was impossible when I did it."

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
