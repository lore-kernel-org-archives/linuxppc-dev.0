To: David de =?iso-8859-1?Q?Andr=E9s=20Mart=EDnez?= <ddandres@disca.upv.es>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Root-NFS: Server returned error -13 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 25 Oct 2001 18:36:18 +0200."
             <3BD83F82.BE5C66A5@disca.upv.es>
Date: Thu, 25 Oct 2001 18:46:03 +0200
Message-Id: <20011025164608.E271F10CD9@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3BD83F82.BE5C66A5@disca.upv.es> you wrote:
>
> I'm trying to boot from NFS but I can't access the directory.
...
> Root-NFS: Server returned error -13 while mounting

errno 13 = Permission denied

> torreta mountd[20966]: Blocked attempt of 158.42.50.66 to mount

Seems onvious: you have blocked access for the target to your server;
check your host access control files (/etc/hosts.allow).

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Whenever people agree with me, I always think I must be wrong.
- Oscar Wilde

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
