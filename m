To: Jin Cheng <jcheng@redswitch.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: root login on ELDK nfs booting 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 28 Aug 2002 11:32:03 PDT."
             <3D6D1722.9421CC3B@redswitch.com>
Date: Wed, 28 Aug 2002 22:14:09 +0200
Message-Id: <20020828201415.10D6D1182F@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3D6D1722.9421CC3B@redswitch.com> you wrote:
>
> I booted on /opt/eldk/ppc_4xx. But it does not allow root login from my
> serial console.
> I changed the /etc/passwd so that I can login in as adm. Anyone can give
> me advice on the
> problem? Thanks.

It's difficult to predict what you changed, and how.

A stab into the dark: when installing the ELDK, did you  remember  to
run  the  ELDK_FIXOWNER  script??  See  section  "7.  Mounting Target
Components via NFS" at http://www.denx.de/ELDK/eldk-nfs.html


Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
1st Old Man:  Gee, its windy today.
2nd Old Man:  No it's not... it's Thursday.
3rd Old Man:  Yeh, me too.  Let's go for a beer.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
