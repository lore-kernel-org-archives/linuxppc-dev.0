From: t.shantha.laxmi@exgate.tek.com
Message-ID: <21F9768AF088D211BF1C0008C71E5786EEFBA7@ap-bang-m02.india.tek.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: 8xxROM on MPC860ADS
Date: Tue, 9 May 2000 07:25:18 -0700 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello all,
I am using 8xxROM on my 860ADS-Rev B board. I have flashed the 8xxROM at the
location: 0x02800000.
I flashed the kernel at the location 0x0280f400. I also changed in the
8xxrom code in the file elf.c, in function bootvm():
        /* changing....
        start_loc = (void ((*)())) *((uint *)0);
        */
        start_loc = (void ((*)())) (0x0280f400);
        printf("Stating 0x%x\n", (uint) start_loc );

The bootrom displays the following messages in the console:

8xxROM 0.3.0

compiletime options:
board: ADS DRAM_50MHZ
disk: DISK_ATA

cpu: XPC860xxZPnnA at 48 MHz: 4Kbyte icache 4Kbyte dcache

<warning: cpu core has silicon bugs, check the errata>

board: ADS rev B
flash: 2 Mbytes, delay 90 ns
dram: EDO, 4 Mbyte, 60 ns, OK
pcmcia: No card present.

Boot device list:
NIP: 00000000 XER: 20004860 LR: FE0043D4 REGS: 003eed80 TRAP: 1000
MSR: 00001002 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 00

GPR00: 00000000 003EEE70 FE0040D0 00000000 00000001 003EEE88 00000000
003EFE10
GPR08: 00000000 FE00A354 00000000 00012600 FF002D78 00080008 000125C0
00000000
GPR16: 00000000 00000000 00000002 FE010000 FE010000 000125B8 28022800
40408221
GPR24: 00000002 00010000 00100000 003F0000 003EFEE8 FF002FDC 003EFF08
003EFEA8
Call backtrace:
00008000 FE006E58 FE007584 FE005094 FE004340 FE0045D4 FE0047F8
FE002490 00400000
Software Emulation Exception

Could anyone pls direct as to what could be going wrong.

Thanks in advance,
- Shantha

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
