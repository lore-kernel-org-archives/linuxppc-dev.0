Message-ID: <398AE7C3.F8936771@erols.com>
Date: Fri, 04 Aug 2000 11:56:51 -0400
From: Nelson Abramson <pogtal@erols.com>
MIME-Version: 1.0
To: Henry Worth <haworth@ncal.verio.com>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: CDDA playback on Pismo (and other newer models)
References: <398A522C.77172439@ncal.verio.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Henry Worth wrote:

> <snip>
> Using the ATAPI CD drivers there are underruns with significant
> dropouts every couple of seconds. Various hdparms and cdparanoia
> parms were tried with no significant change. These include various

<snip>

I had issues using the "cdparanoia 1- - | play - -t WAV" until I realized
that cdparanaoia was trying to do on the fly error correcting, resulting
in the pause every few seconds.  By using the "-Z" flag, which turned off
the error correcting, I got excellent playback with no skips what-so-ever
on my Pismo.

HTH
--Nelson Abramson


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
