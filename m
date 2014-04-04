Return-Path: <curieux.khetan@gmail.com>
Received: from mail-pa0-x22b.google.com (mail-pa0-x22b.google.com
 [IPv6:2607:f8b0:400e:c03::22b])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id CB5CD140088
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Apr 2014 18:42:04 +1100 (EST)
Received: by mail-pa0-f43.google.com with SMTP id bj1so3074834pad.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Apr 2014 00:42:01 -0700 (PDT)
Message-ID: <533E6270.8070700@gmail.com>
Date: Fri, 04 Apr 2014 13:12:40 +0530
From: Ashish <curieux.khetan@gmail.com>
MIME-Version: 1.0
To: sanjeev sharma <sanjeevsharmaengg@gmail.com>
Subject: Re: MPC8641 based custom board Kernel stuck at 1000Mhz core clock
References: <CAERE9PrGaOJS3YTBv61=JCEGyPxGnqr_8j=eKrnn7Y9vi8dMug@mail.gmail.com>
 <52BBF1CB.3070006@gmail.com>
 <CAERE9Prr_C31D96zuYbV0KQ7b_j8Te0A2DO8C+6YtetF0e6M_w@mail.gmail.com>
 <CALyraeMiKQsoHV8AQ5SOz926z_YBD3LbFFNefMpRibYOt=Vo=Q@mail.gmail.com>
 <CAERE9PrX61oNtQoT1tpL_+rXfirFeMa4woD2P2TSUJ_Xj-h4rg@mail.gmail.com>
 <5333FEBD.3050704@gmail.com> <3723.1395937889@turing-police.cc.vt.edu>
 <CAGUYZuR+rymKURoHURemEggZ8uktagyhGGuqtaWvN=11DQsoxw@mail.gmail.com>
In-Reply-To: <CAGUYZuR+rymKURoHURemEggZ8uktagyhGGuqtaWvN=11DQsoxw@mail.gmail.com>
Content-Type: multipart/alternative;
 boundary="------------090709000405010504060306"
Cc: scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org,
 Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
 kernelnewbies <kernelnewbies@kernelnewbies.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------090709000405010504060306
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On Thursday 03 April 2014 08:55 AM, sanjeev sharma wrote:
> Are you able to capture kernel logs ?
>
> Regards
> Sanjeev Sharma
>
>
> On Thu, Mar 27, 2014 at 10:01 PM, <Valdis.Kletnieks@vt.edu 
> <mailto:Valdis.Kletnieks@vt.edu>> wrote:
>
>     On Thu, 27 Mar 2014 16:04:37 +0530, Ashish said:
>     > Hi,
>     >
>     >   I am using MPC8641-HPCN based custom board and able to boot
>     linux at
>     > MPX clock 400Mhz and core clock 800mhz. When I am increasing core
>     > frequency ie MPX clock at 400Mhz and core at 1Ghz, kernel stuck.
>
>     Step 0:  Prove to us that your core actually runs reliable and
>     stably at 1Ghz.
>
>     Step 1: Figure out *where* it gets stuck.  If you have earlyprintk
>     working on
>     your board, adding 'initcall_debug ignore_loglevel' to the kernel
>     cmdline often
>     helps track down where a kernel hangs during boot.
>
>
>     _______________________________________________
>     Kernelnewbies mailing list
>     Kernelnewbies@kernelnewbies.org
>     <mailto:Kernelnewbies@kernelnewbies.org>
>     http://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies
>
>
Hi,
Does kernel logs means debugging information that kernel prints while 
booting using printk or it is something else?
Here is kernel boot logs that kernel printed while booting...

U-Boot 2013.04 (Jan 27 2014 - 11:21:21)

Unicore software on multiprocessor system!!
To enable mutlticore build define CONFIG_MP
CPU:   8641, Version: 2.1, (0x80900021)
Core:  E600 Core 0, Version: 2.2, (0x80040202)
Clock Configuration:
        CPU:1000 MHz, MPX:400  MHz
        DDR:200  MHz (400 MT/s data rate), LBC:25   MHz
L1:    D-cache 32 KB enabled
        I-cache 32 KB enabled
L2:    512 KB enabled
Board: MPC8641-HPCN
I2C:   ready
DRAM:  512 MiB
SDRAM test phase 1:
SDRAM test phase 2:
SDRAM test passed.
Flash: 16 MiB
EEPROM: NXID v1
In:    serial
Out:   serial
Err:   serial
Net:   eTSEC1, eTSEC2, eTSEC3, eTSEC4 [PRIME]
Hit any key to stop autoboot:
Speed: 1000, full duplex
Using eTSEC4 device
TFTP from server 192.168.10.1; our IP address is 192.168.10.2
Filename 'uRamdisk'.
Load address: 0x600000
Loading: 
*#################################################################
  #################################################################
  #################################################################
  #################################################################
  #################################################################
  #################################################################
  #################################################################
  #################################################################
  #################################################################
  #################################################################
  #################################################################
  #################################################################
  #################################################################
  #################################################################
  #################################################################
  #################################################################
  #################################################################
  #################################################################
  #################################################################
  #################################################################
  #################################################################
  #################################################################
  #################################################################
      ##################################################
      13.1 MiB/s
done
Bytes transferred = 22680188 (15a127c hex)
Speed: 1000, full duplex
Using eTSEC4 device
TFTP from server 192.168.10.1; our IP address is 192.168.10.2
Filename 'uImage'.
Load address: 0x16000000
Loading: 
*#################################################################
  #################################################################
      #######################################
      14 MiB/s
done
Bytes transferred = 2476304 (25c910 hex)
Speed: 1000, full duplex
Using eTSEC4 device
TFTP from server 192.168.10.1; our IP address is 192.168.10.2
Filename 'mpc8641_hpcn.dtb'.
Load address: 0x14000000
Loading: *#
      2.6 MiB/s
done
Bytes transferred = 5540 (15a4 hex)
## Booting kernel from Legacy Image at 16000000 ...
    Image Name:   Linux-3.13.6
    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
    Data Size:    2476240 Bytes = 2.4 MiB
    Load Address: 00000000
    Entry Point:  00000000
    Verifying Checksum ... OK
## Loading init Ramdisk from Legacy Image at 00600000 ...
    Image Name:   rootfs
    Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
    Data Size:    22680124 Bytes = 21.6 MiB
    Load Address: 00000000
    Entry Point:  00000000
    Verifying Checksum ... OK
## Flattened Device Tree blob at 14000000
    Booting using the fdt blob at 0x14000000
    Uncompressing Kernel Image ... OK
    Loading Ramdisk to 1e923000, end 1fec423c ... OK
    Loading Device Tree to 007fb000, end 007ff5a3 ... OK /_*(some times 
it stucking here) *_/
Using MPC86xx HPCN machine description
Total memory = 512MB; using 1024kB for hash table (at cff00000)
Linux version 3.13.6 (ashish@ashish-VirtualBox) (gcc version 4.7.2 (GCC) 
) #8 Sat Mar 29 10:31:58 IST 2014
Found initrd at 0xde923000:0xdfec423c
bootconsole [udbg0] enabled
setup_arch: bootmem
mpc86xx_hpcn_setup_arch()
MPC86xx HPCN board from Freescale Semiconductor
arch: exit
Zone ranges:
   DMA      [mem 0x00000000-0x1fffffff]
   Normal   empty
   HighMem  empty
Movable zone start for each node
Early memory node ranges
   node   0: [mem 0x00000000-0x1fffffff] /_*(some times here) *_/



--------------090709000405010504060306
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">On Thursday 03 April 2014 08:55 AM,
      sanjeev sharma wrote:<br>
    </div>
    <blockquote
cite="mid:CAGUYZuR+rymKURoHURemEggZ8uktagyhGGuqtaWvN=11DQsoxw@mail.gmail.com"
      type="cite">
      <div dir="ltr">
        <div>Are you able to capture kernel logs ?<br>
          <br>
        </div>
        Regards<br>
        Sanjeev Sharma<br>
      </div>
      <div class="gmail_extra"><br>
        <br>
        <div class="gmail_quote">On Thu, Mar 27, 2014 at 10:01 PM, <span
            dir="ltr">&lt;<a moz-do-not-send="true"
              href="mailto:Valdis.Kletnieks@vt.edu" target="_blank">Valdis.Kletnieks@vt.edu</a>&gt;</span>
          wrote:<br>
          <blockquote class="gmail_quote" style="margin:0 0 0
            .8ex;border-left:1px #ccc solid;padding-left:1ex">
            <div class="">On Thu, 27 Mar 2014 16:04:37 +0530, Ashish
              said:<br>
              &gt; Hi,<br>
              &gt;<br>
              &gt; &nbsp; I am using MPC8641-HPCN based custom board and able
              to boot linux at<br>
              &gt; MPX clock 400Mhz and core clock 800mhz. When I am
              increasing core<br>
              &gt; frequency ie MPX clock at 400Mhz and core at 1Ghz,
              kernel stuck.<br>
              <br>
            </div>
            Step 0: &nbsp;Prove to us that your core actually runs reliable
            and stably at 1Ghz.<br>
            <br>
            Step 1: Figure out *where* it gets stuck. &nbsp;If you have
            earlyprintk working on<br>
            your board, adding 'initcall_debug ignore_loglevel' to the
            kernel cmdline often<br>
            helps track down where a kernel hangs during boot.<br>
            <br>
            <br>
            _______________________________________________<br>
            Kernelnewbies mailing list<br>
            <a moz-do-not-send="true"
              href="mailto:Kernelnewbies@kernelnewbies.org">Kernelnewbies@kernelnewbies.org</a><br>
            <a moz-do-not-send="true"
              href="http://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies"
              target="_blank">http://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies</a><br>
            <br>
          </blockquote>
        </div>
        <br>
      </div>
    </blockquote>
    Hi, <br>
    Does kernel logs means debugging information that kernel prints
    while booting using printk or it is something else?<br>
    Here is kernel boot logs that kernel printed while booting...<br>
    <br>
    U-Boot 2013.04 (Jan 27 2014 - 11:21:21)
<br>
    &nbsp;<br>
    Unicore software on multiprocessor system!!
<br>
    To enable mutlticore build define CONFIG_MP
<br>
    CPU:&nbsp;&nbsp; 8641, Version: 2.1, (0x80900021)
<br>
    Core:&nbsp; E600 Core 0, Version: 2.2, (0x80040202)
<br>
    Clock Configuration:
<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CPU:1000 MHz, MPX:400&nbsp; MHz
<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DDR:200&nbsp; MHz (400 MT/s data rate), LBC:25&nbsp;&nbsp; MHz
<br>
    L1:&nbsp;&nbsp;&nbsp; D-cache 32 KB enabled
<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I-cache 32 KB enabled
<br>
    L2:&nbsp;&nbsp;&nbsp; 512 KB enabled
<br>
    Board: MPC8641-HPCN<br>
    I2C:&nbsp;&nbsp; ready
<br>
    DRAM:&nbsp; 512 MiB
<br>
    SDRAM test phase 1:
<br>
    SDRAM test phase 2:
<br>
    SDRAM test passed.
<br>
    Flash: 16 MiB
<br>
    EEPROM: NXID v1
<br>
    In:&nbsp;&nbsp;&nbsp; serial
<br>
    Out:&nbsp;&nbsp; serial
<br>
    Err:&nbsp;&nbsp; serial
<br>
    Net:&nbsp;&nbsp; eTSEC1, eTSEC2, eTSEC3, eTSEC4 [PRIME]
<br>
    Hit any key to stop autoboot: <br>
    Speed: 1000, full duplex
<br>
    Using eTSEC4 device
<br>
    TFTP from server 192.168.10.1; our IP address is 192.168.10.2
<br>
    Filename 'uRamdisk'.
<br>
    Load address: 0x600000
<br>
    Loading:
    *#################################################################
<br>
    &nbsp;&nbsp;&nbsp;
    &nbsp;#################################################################
<br>
    &nbsp;&nbsp;&nbsp;
    &nbsp;#################################################################
<br>
    &nbsp;&nbsp;&nbsp;
    &nbsp;#################################################################
<br>
    &nbsp;&nbsp;&nbsp;
    &nbsp;#################################################################
<br>
    &nbsp;&nbsp;&nbsp;
    &nbsp;#################################################################
<br>
    &nbsp;&nbsp;&nbsp;
    &nbsp;#################################################################
<br>
    &nbsp;&nbsp;&nbsp;
    &nbsp;#################################################################
<br>
    &nbsp;&nbsp;&nbsp;
    &nbsp;#################################################################
<br>
    &nbsp;&nbsp;&nbsp;
    &nbsp;#################################################################
<br>
    &nbsp;&nbsp;&nbsp;
    &nbsp;#################################################################
<br>
    &nbsp;&nbsp;&nbsp;
    &nbsp;#################################################################
<br>
    &nbsp;&nbsp;&nbsp;
    &nbsp;#################################################################
<br>
    &nbsp;&nbsp;&nbsp;
    &nbsp;#################################################################
<br>
    &nbsp;&nbsp;&nbsp;
    &nbsp;#################################################################
<br>
    &nbsp;&nbsp;&nbsp;
    &nbsp;#################################################################
<br>
    &nbsp;&nbsp;&nbsp;
    &nbsp;#################################################################
<br>
    &nbsp;&nbsp;&nbsp;
    &nbsp;#################################################################
<br>
    &nbsp;&nbsp;&nbsp;
    &nbsp;#################################################################
<br>
    &nbsp;&nbsp;&nbsp;
    &nbsp;#################################################################
<br>
    &nbsp;&nbsp;&nbsp;
    &nbsp;#################################################################
<br>
    &nbsp;&nbsp;&nbsp;
    &nbsp;#################################################################
<br>
    &nbsp;&nbsp;&nbsp;
    &nbsp;#################################################################
<br>
    &nbsp;&nbsp;&nbsp; &nbsp;##################################################
<br>
    &nbsp;&nbsp;&nbsp; &nbsp;13.1 MiB/s
<br>
    done
<br>
    Bytes transferred = 22680188 (15a127c hex)
<br>
    Speed: 1000, full duplex
<br>
    Using eTSEC4 device
<br>
    TFTP from server 192.168.10.1; our IP address is 192.168.10.2
<br>
    Filename 'uImage'.
<br>
    Load address: 0x16000000
<br>
    Loading:
    *#################################################################
<br>
    &nbsp;&nbsp;&nbsp;
    &nbsp;#################################################################
<br>
    &nbsp;&nbsp;&nbsp; &nbsp;#######################################
<br>
    &nbsp;&nbsp;&nbsp; &nbsp;14 MiB/s
<br>
    done
<br>
    Bytes transferred = 2476304 (25c910 hex)
<br>
    Speed: 1000, full duplex
<br>
    Using eTSEC4 device
<br>
    TFTP from server 192.168.10.1; our IP address is 192.168.10.2
<br>
    Filename 'mpc8641_hpcn.dtb'.
<br>
    Load address: 0x14000000
<br>
    Loading: *#
<br>
    &nbsp;&nbsp;&nbsp; &nbsp;2.6 MiB/s
<br>
    done
<br>
    Bytes transferred = 5540 (15a4 hex)
<br>
    ## Booting kernel from Legacy Image at 16000000 ...
<br>
    &nbsp;&nbsp; Image Name:&nbsp;&nbsp; Linux-3.13.6
<br>
    &nbsp;&nbsp; Image Type:&nbsp;&nbsp; PowerPC Linux Kernel Image (gzip compressed)
<br>
    &nbsp;&nbsp; Data Size:&nbsp;&nbsp;&nbsp; 2476240 Bytes = 2.4 MiB
<br>
    &nbsp;&nbsp; Load Address: 00000000
<br>
    &nbsp;&nbsp; Entry Point:&nbsp; 00000000
<br>
    &nbsp;&nbsp; Verifying Checksum ... OK
<br>
    ## Loading init Ramdisk from Legacy Image at 00600000 ...
<br>
    &nbsp;&nbsp; Image Name:&nbsp;&nbsp; rootfs
<br>
    &nbsp;&nbsp; Image Type:&nbsp;&nbsp; PowerPC Linux RAMDisk Image (gzip compressed)
<br>
    &nbsp;&nbsp; Data Size:&nbsp;&nbsp;&nbsp; 22680124 Bytes = 21.6 MiB
<br>
    &nbsp;&nbsp; Load Address: 00000000
<br>
    &nbsp;&nbsp; Entry Point:&nbsp; 00000000
<br>
    &nbsp;&nbsp; Verifying Checksum ... OK
<br>
    ## Flattened Device Tree blob at 14000000
<br>
    &nbsp;&nbsp; Booting using the fdt blob at 0x14000000
<br>
    &nbsp;&nbsp; Uncompressing Kernel Image ... OK
<br>
    &nbsp;&nbsp; Loading Ramdisk to 1e923000, end 1fec423c ... OK
<br>
    &nbsp;&nbsp; Loading Device Tree to 007fb000, end 007ff5a3 ... OK&nbsp;&nbsp;&nbsp; <i><u><b>(some
          times it stucking here)
</b></u></i><br>
    Using MPC86xx HPCN machine description
<br>
    Total memory = 512MB; using 1024kB for hash table (at cff00000)
<br>
    Linux version 3.13.6 (ashish@ashish-VirtualBox) (gcc version 4.7.2
    (GCC) ) #8 Sat Mar 29 10:31:58 IST 2014
<br>
    Found initrd at 0xde923000:0xdfec423c
<br>
    bootconsole [udbg0] enabled
<br>
    setup_arch: bootmem
<br>
    mpc86xx_hpcn_setup_arch()
<br>
    MPC86xx HPCN board from Freescale Semiconductor
<br>
    arch: exit
<br>
    Zone ranges:
<br>
    &nbsp; DMA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [mem 0x00000000-0x1fffffff]
<br>
    &nbsp; Normal&nbsp;&nbsp; empty
<br>
    &nbsp; HighMem&nbsp; empty
<br>
    Movable zone start for each node
<br>
    Early memory node ranges
<br>
    &nbsp; node&nbsp;&nbsp; 0: [mem 0x00000000-0x1fffffff]
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; <i><u><b>(some
          times here)
        </b></u></i><br>
    <br>
    <br>
  </body>
</html>

--------------090709000405010504060306--
