Message-ID: <3FAA07B0.4070309@elettra.trieste.it>
Date: Thu, 06 Nov 2003 09:34:56 +0100
From: Vincenzo Forchi` <vincenzo.forchi@elettra.trieste.it>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org, grave@ipno.in2p3.fr
Subject: Re: rtai + mvme5500 boot
References: <3FA8F643.3040007@elettra.trieste.it> <20031105154540.GE22947@ipnpcu9.acq.ami>
In-Reply-To: <20031105154540.GE22947@ipnpcu9.acq.ami>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


xavier grave wrote:
>>
> In order to boot I use the following command :
> netBoot -s192.168.120.70 -s192.168.120.75 -fzImage.pplus -z
>
> the -z option is really important (don't boot)
>
now it boots, it was the -z option, thanks for your help.
just another question: how can I setup the board to perform netBoot
automatically at each power-up?

Vincenzo

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
