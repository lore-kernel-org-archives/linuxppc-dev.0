Message-ID: <3F77DF36.5000609@einfochips.com>
Date: Mon, 29 Sep 2003 12:58:54 +0530
From: bhavin <bhavinp@einfochips.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: ELDK & ppc-boot1.1.5
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


  Hello,
    I downloaded ELDK 2.0.2 . When I tried to compile ppcboot 1.1.5 it
gave me following error.  I did not even change the code of ppcboot. I
tried to compile it for PM826 card. Can anyone please please tell me the
possible reasons??

Error: Unrecognized opcode: `psdmr_acttorw_1w'
/home/bhavin/ppcproj/ppcboot-1.1.5/include/config_PM826.h:427:
Error: Unrecognized opcode: `psdmr_ldotopre_1c'
/home/bhavin/ppcproj/ppcboot-1.1.5/include/config_PM826.h:428:
Error: Unrecognized opcode: `psdmr_wrc_1c'
/home/bhavin/ppcproj/ppcboot-1.1.5/include/config_PM826.h:429:
Error: Unrecognized opcode: `psdmr_cl_2)'
make[1]: *** [ticks.o] Error 1
make[1]: Leaving directory
`/home/bhavin/ppcproj/ppcboot-1.1.5/ppc'
make: *** [subdirs] Error 1


Your help will be highly appreciated.

Thanks,
Bhavin Shah
Embedded Engineer
eInfochips Ltd.,
bhavinp@einfochips.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
