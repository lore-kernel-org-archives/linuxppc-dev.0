Reply-To: <yooth@ipone.co.kr>
From: "Yoo. Jonghoon" <yooth@ipone.co.kr>
To: "SangTae Ha" <stha@postech.edu>,
	<linuxppc-embedded@lists.linuxppc.org>
Subject: RE: RPXclassic PPCBOOT on RAM
Date: Mon, 25 Jun 2001 15:42:50 +0900
Message-ID: <NFBBLHGHILCOPCKBODHAAEAJCBAA.yooth@ipone.co.kr>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <010601c0fd39$ef0cca90$3877b5d3@dolbae>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>From my experience, it is required at least 3 things to
be changed If ppcboot works well from flash,
(1) TEXT_BASE to be located in RAM
(2) set CFG_MONITOR_BASE equal to TEXT_BASE
(3) skip DRAM initializaion sequence in func. initdram(),
     except returning size of DRAM.

Good luck to you

===============================================
Yoo. Jonghoon,        IPone inc.
===============================================
e-mail : yooth@ipone.co.kr
tel : 82-2-02-2222-4631
===============================================

> -----Original Message-----
> From: owner-linuxppc-embedded@lists.linuxppc.org
> [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of SangTae Ha
> Sent: Monday, June 25, 2001 2:45 PM
> To: linuxppc-embedded@lists.linuxppc.org
> Subject: RPXclassic PPCBOOT on RAM
>
>
>
> I am trying to have the PPCBOOT work on RPXclassic board. I've
> already port the 8xxROM this board already but I've failed with
> PPCBOOT. All configuration parameters are same with 8xxROM and my
> BDI2000 didn't get the flash information of RPXClassic (FLASH
> TYPE, CHIPSIZE, BUSWIDTH), therefore I really want to test the
> PPCBOOT on RAM space first to debug. In order to make srec file
> run on RAM space, I changed TEXT_BASE=0x00100000 parameter in
> config.mk. I think there woule be many efficient debugging
> techniques. I am currently using BDI2000, as I mentioned above,
> but I couldn't get the flash work. How can I debug the PPCBOOT
> efficiently in my current stage? Any comments would be appreciated.
>
> Thanks in advance.
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
