Message-Id: <5.1.1.2.2.20020607224913.04403008@mail.lauterbach.com>
Date: Fri, 07 Jun 2002 22:50:24 +0200
To: "Kevin B. Hendricks" <kevin.hendricks@sympatico.ca>
From: Franz Sirl <Franz.Sirl-ppc@lauterbach.com>
Subject: Re: can/should we use gcc 3.1 to compile kernels
Cc: Tom Rini <trini@kernel.crashing.org>,
	linuxppc-dev@lists.linuxppc.org
In-Reply-To: <200206071644.08382.kevin.hendricks@sympatico.ca>
References: <20020607201906.GP14252@opus.bloom.county>
 <200206081337.31359.kevin.hendricks@sympatico.ca>
 <200206071544.56448.kevin.hendricks@sympatico.ca>
 <20020607201906.GP14252@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 22:44 07.06.2002, Kevin B. Hendricks wrote:

>Hi,
>
>
>#define CNTRL_REG(INFO,REG) (&(((INFO)->control_regs-> ## REG).r))
                                                        ^^^^
                                                      superflous

Just remove that and you'll be fine.

Franz.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
