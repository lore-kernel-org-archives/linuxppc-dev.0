Subject: Re: Howto login without PAM authentication?
From: Alex Zeffertt <ajz@cambridgebroadband.com>
To: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <F100yCBCpIP6EeaLQBs00012c26@hotmail.com>
References: <F100yCBCpIP6EeaLQBs00012c26@hotmail.com>
Content-Type: text/plain
Date: 18 Dec 2002 10:14:52 +0000
Message-Id: <1040206492.31830.4414.camel@zambia>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Enrico,

I don't know about ELDK - we're using SELF - but I suspect that it uses
busybox.  If so, then just build "login" as part of busybox (to do this
you must edit the busybox/Config.in file,) then add the following line
to your /etc/inittab:

ttyS0::respawn:/sbin/login

This is what we have done and we don't have any PAM libraries on our
system at all.

Alex

PS We're using a plain /etc/password file without shadowing

On Tue, 2002-12-17 at 09:14, Enrico Serretti wrote:
>
> Hi all,
> we are using ELDK environment. We would like use login authentication
> without PAM libraries. Had anybody done it ?
>
> Thanks,
> Enrico.
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
