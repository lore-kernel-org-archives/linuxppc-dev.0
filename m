To: "Xiaolong Li" <lxl@softhome.net>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: ppc linux kernel 2.4.4 for ppc440/EBony using ELDK 2.0.2? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 02 Apr 2003 17:24:59 -0800."
             <009801c2f97f$d8917790$1464a8c0@sjeng3>
Date: Thu, 03 Apr 2003 09:27:21 +0200
Message-Id: <20030403072726.78B9EC587C@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <009801c2f97f$d8917790$1464a8c0@sjeng3> you wrote:
>
> I am currently working on IBM's 440GP Ebony evaluation board,
> trying to run Linux on it. I installed ELDK 2.0.2 on RedHat 7.1,
> and sucessfully compiled ppcboot, which runs smoothly on 440GP.
>
> Now I am trying to build a Linux kernel 2.4.4 (which is included in
> ELDK 2.0.2), but I see some errors regarding to mfdcr/DCRN_EXISR.

The 2.4.4 LInux kernel as included in this version of the ELDK is not
suitable for 4xx systems. Please use  the  linuxppc_2_4_devel  kernel
tree instead; see http://penguinppc.org/dev/kernel.shtml


Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Randal said it would be tough to do in sed. He didn't say  he  didn't
understand  sed.  Randal  understands sed quite well. Which is why he
uses Perl. :-)         - Larry Wall in <7874@jpl-devvax.JPL.NASA.GOV>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
