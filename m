Message-ID: <007601c105e0$06624040$3877b5d3@dolbae>
From: "SangTae Ha" <stha@postech.edu>
To: <yooth@ipone.co.kr>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <NFBBLHGHILCOPCKBODHAEEFOCBAA.yooth@ipone.co.kr>
Subject: Re: microcode patch for smc1, scc3?
Date: Fri, 6 Jul 2001 14:53:39 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


You had better use smc2 instead. I had a exact same problem with you on my early work with 850DE. Finally  I used smc2 instead in order to bring up all interfaces. It works well.
Cheers!

Regards,

SangTae Ha

----- Original Message -----
From: "Yoo. Jonghoon" <yooth@ipone.co.kr>
To: "linuxppc-embedded" <linuxppc-embedded@lists.linuxppc.org>
Sent: Friday, July 06, 2001 11:20 AM
Subject: microcode patch for smc1, scc3?


>
> Hi.
> my custom board(850DE) uses smc1 for console and
> scc2, scc3 for ethernet. I found that scc3 does not work
> because of conflicting dpram area.
> Does anybody know microcode patch relocates smc1
> to some other place? I've searched motorola site but
> couldn't find that.
> is there exists such microcode patch? or must I change
> console to smc2?
>
> thanks in advance.
>
> ===============================================
> Yoo. Jonghoon,        IPone inc.
> ===============================================
> e-mail : yooth@ipone.co.kr
> tel : 82-2-02-2222-4631
> ===============================================
>
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
