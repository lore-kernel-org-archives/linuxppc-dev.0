Message-ID: <3E2FEEB0.8010809@tataelxsi.co.in>
Date: Thu, 23 Jan 2003 19:01:28 +0530
From: "Omanakuttan" <omanakuttan@tataelxsi.co.in>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: uncompressing linux... (it hangs after this message)
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
I am a embedded linux newbie and I am using ppcboot to load my kernel.
I use `mkimage` of ramdisk supplied in SELF.
I made a linux kernel for ppc with bare minimum options, no loadable
modules.

The steps I followed.

<reset>
PPCBoot 2.0.0 (Jan 22 2003 - 12:00:07)

MPC8260 Reset Status: External Soft, External Hard

MPC8260 Clock Configuration
  - Bus-to-Core Mult 2x, VCO Div 2, 60x Bus Freq  50-150, Core Freq 100-300
  - dfbrg 0, corecnf 0x04, busdf 3, cpmdf 1, plldf 0, pllmf 1
  - vco_out  266666664, scc_clk   66666666, brg_clk   66666666
  - cpu_clk  133333332, cpm_clk  133333332, bus_clk   66666666

CPU:   MPC8260 (Rev 14, Mask A.0(A) 2K25A) at 133.333 MHz
Board: Motorola MPC8260ADS
I2C:   ready
DRAM:  16 MB
FLASH:  8 MB
In:    serial
Out:   serial
Err:   serial
Hit any key to stop autoboot:  0

=> tftpboot 0x100000 image
ARP broadcast 1
TFTP from server 10.1.40.7; our IP address is 10.1.40.58
Filename 'image'.
Load address: 0x100000
Loading: #################################################################
done
Bytes transferred = 546674 (85772 hex)
=> tftpboot 0x200000 ramdisk
ARP broadcast 1
TFTP from server 10.1.40.7; our IP address is 10.1.40.58
Filename 'ramdisk'.
Load address: 0x200000
Loading: #################################################################
done
Bytes transferred = 1400262 (155dc6 hex)

=> bootm 0x100000 0x200000
## Booting image at 00100000 ...
    Image Name:   Tata Elxsi
    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
    Data Size:    546610 Bytes = 533.8 kB
    Load Address: 00000000
    Entry Point:  00000000
    Verifying Checksum ... OK
    Uncompressing Kernel Image ... OK
## Loading RAMDisk Image at 00200000 ...
    Image Name:   Tata Elxsi
    Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
    Data Size:    1400198 Bytes =  1.3 MB
    Load Address: 00000000
    Entry Point:  00000000
    Verifying Checksum ... OK
    Loading Ramdisk to 00e09000, end 00f5ed86 ... OK

 From this point onwards there is no messages. and no cpu activity.
I have absolutely no idea of what is happening.
Any clue?


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
