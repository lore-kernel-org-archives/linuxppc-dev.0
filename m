To: xiaogeng_jin@agilent.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MPC8245 supported in Linux kernel (devel tree from DENX)? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 09 Sep 2003 19:04:17 MDT."
             <9153F74610B7D311B83900902771C871124D94BC@axcs07.cos.agilent.com>
Date: Wed, 10 Sep 2003 10:00:15 +0200
Message-Id: <20030910080020.14B11C59E4@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Shawn,

in message <9153F74610B7D311B83900902771C871124D94BC@axcs07.cos.agilent.com> you wrote:
>
> Is MPC8245 supported in the linux kernel downloaded from the devel tree of DENX? I only found six types of processors supported by default, which are 6xx/7xx/74xx/8260, 40x, 440, POWER3, 8xx, and iSeries. If yes, which type shall I select? If not, is th
> ere anybody going to support this? U-Boot seems to support this by 824x.

The MPC8245 is supported by the Linux kernel, too.  Please  configure
for  a  standard 6xx CPU (CONFIG_PPC=y, CONFIG_PPC32=y, CONFIG_6xx=y,
CONFIG_PPC_STD_MMU=y).

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
All he had was nothing, but that was something, and now it  had  been
taken away.                             - Terry Pratchett, _Sourcery_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
