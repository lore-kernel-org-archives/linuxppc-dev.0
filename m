Message-Id: <4.3.2.7.2.20001011091843.00ab82a0@nostromo.cdf.tel>
Date: Wed, 11 Oct 2000 09:30:34 +0100
To: Zhaobin Zhu <zzhu@emc.com>
From: Eurico Inocencio <emi@cdftel.pt>
Subject: Re: exchanges file in minicom
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <39E3915B.528A90FF@emc.com>
References: <Pine.HPX.4.10.10010102202210.16113-100000@gra-ux1.iram.es>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello

>After kernel is running on target, how can I send/receive files between
>host(minicom/linux) and target ?
>For ascii file, I can use "cat  < /dev/ttyS0" on target, and
>"ascii-xfr .." on host. How about Binary files ?

Try ZMODEM, minicom can send and receive files using this
protocol, on the target you need to compile the ´rz' and
or 'sz' programs on your target, or like we do here, integrate
the ZMODEM protocol into the target application.

Like many others we have been using ZMODEM for a number
of years, with both minicom and the win98 "hyper terminal",
both are great for binary file transfers to the target.

Best Regards
Eurico
-----------------------------------------------------------------------
  Eurico Mendes Inocencio          CDFtel,
Lda
  Ph. No:  +351.22.3389843         Rua Goncalo Cristovao, 347 - Sala 205
  FAX No:  +351.22.3389845         4000-270 PORTO
  E-mail:  mailto:emi@cdftel.pt    Portugal
-----------------------------------------------------------------------


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
