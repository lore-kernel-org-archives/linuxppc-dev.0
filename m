To: linuxppc-dev@lists.linuxppc.org
From: Gerd Knorr <kraxel@bytesex.org>
Subject: Re: anyone with bmac network problem?
Date: 15 Mar 2001 21:51:10 GMT
Message-ID: <slrn9b2eae.bdh.kraxel@macintoy.masq.in-berlin.de>
References: <Pine.A41.3.96LJ1.1b7.1010315122129.41552B-100000@unlserve.unl.edu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Takashi Oe wrote:
>
> Hi,
>
> I'm looking for testers on a possible workaround for bmac network problem.
> As some of you might know, bmac tx dies abruptly when network environment
> is very busy and never recovers.  A patch enclosed might alleviate the
> situation, and I want to know if it works for anybody else.
>
> --- bmac.c.ORIG	Sun Dec 10 18:49:42 2000
> +++ bmac.c	Thu Mar 15 12:38:00 2001
[ ... ]

Cool, seems to fix it for me.  My box (RevB iMac) survived a full motif
build on a NFS filesystem without problems.  Looks like I can turn
of my network-card-monitor-cronjob now (ifconfig down/up used to bring
the box online again with the buggy driver, which was exactly what the
crobjob did if it wasn't able to ping the default gateway).

  Gerd

--
Get back there in front of the computer NOW. Christmas can wait.
	-- Linus "the Grinch" Torvalds,  24 Dec 2000 on linux-kernel

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
