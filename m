Date: Tue, 27 Mar 2001 21:21:45 +0100
Subject: aci7xxxx build fails 2.4.3-p{3..8}
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="utf-8"
Message-Id: <20010327202214.1A68ADBA52@atlas.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,
I've been getting build failures for the aic7xxx driver since -pre3 (the
complaint varies but the end result is the same).  I don't use this driver
but normally build-in in case I post a binary for the kernel....

here's the tail end of the failed build from -pre8

yacc  aicasm/aicasm_gram.y
mv -f y.tab.c aicasm/aicasm_gram.c
lex  -t aicasm/aicasm_scan.l > aicasm/aicasm_scan.c
make -C aicasm
make[5]: Entering directory
`/usr/src/linuxppc_2_4/drivers/scsi/aic7xxx/aicasm'
gcc -I/usr/include -ldb1 aicasm_gram.c aicasm_scan.c aicasm.c
aicasm_symbol.c -o aicasm
aicasm/aicasm_gram.y:45: ../queue.h: No such file or directory
aicasm/aicasm_gram.y:50: aicasm.h: No such file or directory
aicasm/aicasm_gram.y:51: aicasm_symbol.h: No such file or directory
aicasm/aicasm_gram.y:52: aicasm_insformat.h: No such file or directory
aicasm/aicasm_scan.l:44: ../queue.h: No such file or directory
aicasm/aicasm_scan.l:49: aicasm.h: No such file or directory
aicasm/aicasm_scan.l:50: aicasm_symbol.h: No such file or directory
aicasm/aicasm_scan.l:51: y.tab.h: No such file or directory
make[5]: *** [aicasm] Error 1
make[5]: Leaving directory
`/usr/src/linuxppc_2_4/drivers/scsi/aic7xxx/aicasm'

ciao,
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
