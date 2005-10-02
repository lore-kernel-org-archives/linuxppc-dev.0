Return-Path: <marvin24@gmx.de>
Received: from mail.gmx.net (pop.gmx.de [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id B4018683EC
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Oct 2005 02:46:16 +1000 (EST)
From: Marc <marvin24@gmx.de>
To: linuxppc-dev@ozlabs.org,
 linux-kernel@vger.kernel.org
Date: Sun, 2 Oct 2005 18:46:09 +0200
References: <200510011429.45698.marvin24@gmx.de>
In-Reply-To: <200510011429.45698.marvin24@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200510021846.09860.marvin24@gmx.de>
Subject: Re: clock skew on B/W G3
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Some additions to the previous mail: I was able to isolate the problem to t=
he=20
introduction of a user specificable value of HZ (in include/asm-ppc/parm.h)=
=2E=20
I used a value of 250 while the former default was 1000. Setting it back to=
=20
1000 makes the clock tick right again.

Is the CONFIG_HZ known to be broken on PPC ?

Thanks

Marc

Le Samstag 01 Oktober 2005 14:29, marvin24@gmx.de a =C3=A9crit :
> Hi,
>
> something between 2.6.13-git4 and 2.6.14-git5 makes my clock running ~20%
                                        ^^ should be 13 of course=20

> slower. This problem still exists in current kernel versions. Sorry for
> reporting so late, but I hope it would go away while time passes...
>
> As the subject says I have blue/white Apple G3/400. My config I attached.
