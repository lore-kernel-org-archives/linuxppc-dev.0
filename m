To: "zhongqx" <zhongqx@guoguang.com.cn>
Cc: "MirekP" <ntr_stukacz@poczta.onet.pl>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: All is OK! 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 19 Jun 2002 12:45:18 +0800."
             <000701c2174c$1de38ac0$7301a8c0@zhongqx>
Date: Wed, 19 Jun 2002 08:09:26 +0200
Message-Id: <20020619060931.8890910300@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <000701c2174c$1de38ac0$7301a8c0@zhongqx> you wrote:
>
> Hi,
>     Good afternoon!
>     Tell you a good message! I have solved the probelm!Now Linux 2.4.18 run on
> My fads board quite well.thank you very much! you give me much help! I appreciate
> you indeed!so i want to evryone know what i did.when you define CONFIG_CLOCKS_IN_MHZ=1,
> you should update two place with MPC8xx board:

This is wrong. When you run a 2.4.5-pre5 or later kernel  you  should
simply NOT define CONFIG_CLOCKS_IN_MHZ in your PPCBoot configuration,
and all is well. NO CHANGES to the Linux code are required.

Please read the relevant documentation  in  the  PPCBoot  README  and
CHANGELOG files!

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"Tell the truth and run."                          - Yugoslav proverb

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
