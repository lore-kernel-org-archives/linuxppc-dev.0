Subject: Re: MPC8245 supported in Linux kernel (devel tree from DENX)?
From: Hubert Figuiere <hub-linux-ppc@trantor.staff.proxad.net>
To: xiaogeng_jin@agilent.com
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <9153F74610B7D311B83900902771C871124D94BC@axcs07.cos.agilent.com>
References: 
	 <9153F74610B7D311B83900902771C871124D94BC@axcs07.cos.agilent.com>
Content-Type: text/plain; charset=iso-8859-15
Message-Id: <1063179011.30372.6.camel@trantor.staff.proxad.net>
Mime-Version: 1.0
Date: Wed, 10 Sep 2003 09:30:11 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, 2003-09-10 at 03:04, xiaogeng_jin@agilent.com wrote:
> Hi,
>
> Is MPC8245 supported in the linux kernel downloaded from the devel tree of DENX? I only found six types of processors supported by default, which are 6xx/7xx/74xx/8260, 40x, 440, POWER3, 8xx, and iSeries. If yes, which type shall I select? If not, is there anybody going to support this? U-Boot seems to support this by 824x.

MPC8245 is a basically a 603e core with some embedded controllers. There
is AFAIK support for it in the kernel (at least the mvista brand) and
for the MPC8240. Specific stuff is in mpc10x_common.c
Select 6xx CPU type.


Hub
--
Hubert Figuière - Freebox SA. - +33 1 73 50 2 563
AIM/Yahoo!: hfiguiere, ICQ: 307453487

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
