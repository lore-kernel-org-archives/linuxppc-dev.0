Message-Id: <200206072141.GAA23948@mail.highway.ne.jp>
Date: Sat, 8 Jun 2002 06:40:23 +0900 (JST)
From: Kaoru Fukui <k_fukui@highway.ne.jp>
Subject: Re: can/should we use gcc 3.1 to compile kernels
To: Franz.Sirl-ppc@lauterbach.com
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <5.1.1.2.2.20020607224913.04403008@mail.lauterbach.com>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  7 Jun, Franz Sirl wrote:
>
> At 22:44 07.06.2002, Kevin B. Hendricks wrote:
>
>>Hi,
>>
>>
>>#define CNTRL_REG(INFO,REG) (&(((INFO)->control_regs-> ## REG).r))
>                                                         ^^^^
>                                                       superflous
>
> Just remove that and you'll be fine.
>
> Franz.

Thanks.
gcc-3.2 gave me error with this problem (not warning).

I will try this.

Kaoru


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
