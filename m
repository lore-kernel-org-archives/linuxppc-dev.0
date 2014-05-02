Return-Path: <sanjeevsharmaengg@gmail.com>
Received: from mail-oa0-f47.google.com (mail-oa0-f47.google.com
 [209.85.219.47])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id DE8F8140107
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 May 2014 13:52:15 +1000 (EST)
Received: by mail-oa0-f47.google.com with SMTP id i11so4546739oag.6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 May 2014 20:52:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <533E6270.8070700@gmail.com>
References: <CAERE9PrGaOJS3YTBv61=JCEGyPxGnqr_8j=eKrnn7Y9vi8dMug@mail.gmail.com>
 <52BBF1CB.3070006@gmail.com>
 <CAERE9Prr_C31D96zuYbV0KQ7b_j8Te0A2DO8C+6YtetF0e6M_w@mail.gmail.com>
 <CALyraeMiKQsoHV8AQ5SOz926z_YBD3LbFFNefMpRibYOt=Vo=Q@mail.gmail.com>
 <CAERE9PrX61oNtQoT1tpL_+rXfirFeMa4woD2P2TSUJ_Xj-h4rg@mail.gmail.com>
 <5333FEBD.3050704@gmail.com>
 <3723.1395937889@turing-police.cc.vt.edu>
 <CAGUYZuR+rymKURoHURemEggZ8uktagyhGGuqtaWvN=11DQsoxw@mail.gmail.com>
 <533E6270.8070700@gmail.com>
Date: Fri, 2 May 2014 09:22:12 +0530
Message-ID: <CAGUYZuSShhQUiHENFKaMowjJJ5q-fC7yN7HtvWJBNVWxDmTRXA@mail.gmail.com>
Subject: Re: MPC8641 based custom board Kernel stuck at 1000Mhz core clock
From: sanjeev sharma <sanjeevsharmaengg@gmail.com>
To: Ashish <curieux.khetan@gmail.com>
Content-Type: multipart/alternative; boundary=001a11c33b02e6bd1604f862b4ac
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

--001a11c33b02e6bd1604f862b4ac
Content-Type: text/plain; charset=UTF-8

Hello Ashish,

is this issue resolved and is this always happening when you are changing
core to 1Ghz because i am confused here with sometime Keyword.

Regards
Sanjeev Sharma


On Fri, Apr 4, 2014 at 1:12 PM, Ashish <curieux.khetan@gmail.com> wrote:

>  On Thursday 03 April 2014 08:55 AM, sanjeev sharma wrote:
>
>  Are you able to capture kernel logs ?
>
>  Regards
> Sanjeev Sharma
>
>
> On Thu, Mar 27, 2014 at 10:01 PM, <Valdis.Kletnieks@vt.edu> wrote:
>
>> On Thu, 27 Mar 2014 16:04:37 +0530, Ashish said:
>> > Hi,
>> >
>> >   I am using MPC8641-HPCN based custom board and able to boot linux at
>> > MPX clock 400Mhz and core clock 800mhz. When I am increasing core
>> > frequency ie MPX clock at 400Mhz and core at 1Ghz, kernel stuck.
>>
>>  Step 0:  Prove to us that your core actually runs reliable and stably at
>> 1Ghz.
>>
>> Step 1: Figure out *where* it gets stuck.  If you have earlyprintk
>> working on
>> your board, adding 'initcall_debug ignore_loglevel' to the kernel cmdline
>> often
>> helps track down where a kernel hangs during boot.
>>
>>
>> _______________________________________________
>> Kernelnewbies mailing list
>> Kernelnewbies@kernelnewbies.org
>> http://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies
>>
>>
>  Hi,
> Does kernel logs means debugging information that kernel prints while
> booting using printk or it is something else?
> Here is kernel boot logs that kernel printed while booting...
>
> U-Boot 2013.04 (Jan 27 2014 - 11:21:21)
>
> Unicore software on multiprocessor system!!
> To enable mutlticore build define CONFIG_MP
> CPU:   8641, Version: 2.1, (0x80900021)
> Core:  E600 Core 0, Version: 2.2, (0x80040202)
> Clock Configuration:
>        CPU:1000 MHz, MPX:400  MHz
>        DDR:200  MHz (400 MT/s data rate), LBC:25   MHz
> L1:    D-cache 32 KB enabled
>        I-cache 32 KB enabled
> L2:    512 KB enabled
> Board: MPC8641-HPCN
> I2C:   ready
> DRAM:  512 MiB
> SDRAM test phase 1:
> SDRAM test phase 2:
> SDRAM test passed.
> Flash: 16 MiB
> EEPROM: NXID v1
> In:    serial
> Out:   serial
> Err:   serial
> Net:   eTSEC1, eTSEC2, eTSEC3, eTSEC4 [PRIME]
> Hit any key to stop autoboot:
> Speed: 1000, full duplex
> Using eTSEC4 device
> TFTP from server 192.168.10.1; our IP address is 192.168.10.2
> Filename 'uRamdisk'.
> Load address: 0x600000
> Loading: *
> #################################################################
>      #################################################################
>      #################################################################
>      #################################################################
>      #################################################################
>      #################################################################
>      #################################################################
>      #################################################################
>      #################################################################
>      #################################################################
>      #################################################################
>      #################################################################
>      #################################################################
>      #################################################################
>      #################################################################
>      #################################################################
>      #################################################################
>      #################################################################
>      #################################################################
>      #################################################################
>      #################################################################
>      #################################################################
>      #################################################################
>      ##################################################
>      13.1 MiB/s
> done
> Bytes transferred = 22680188 (15a127c hex)
> Speed: 1000, full duplex
> Using eTSEC4 device
> TFTP from server 192.168.10.1; our IP address is 192.168.10.2
> Filename 'uImage'.
> Load address: 0x16000000
> Loading: *
> #################################################################
>      #################################################################
>      #######################################
>      14 MiB/s
> done
> Bytes transferred = 2476304 (25c910 hex)
> Speed: 1000, full duplex
> Using eTSEC4 device
> TFTP from server 192.168.10.1; our IP address is 192.168.10.2
> Filename 'mpc8641_hpcn.dtb'.
> Load address: 0x14000000
> Loading: * #
>      2.6 MiB/s
> done
> Bytes transferred = 5540 (15a4 hex)
> ## Booting kernel from Legacy Image at 16000000 ...
>    Image Name:   Linux-3.13.6
>    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>    Data Size:    2476240 Bytes = 2.4 MiB
>    Load Address: 00000000
>    Entry Point:  00000000
>    Verifying Checksum ... OK
> ## Loading init Ramdisk from Legacy Image at 00600000 ...
>    Image Name:   rootfs
>    Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
>    Data Size:    22680124 Bytes = 21.6 MiB
>    Load Address: 00000000
>    Entry Point:  00000000
>    Verifying Checksum ... OK
> ## Flattened Device Tree blob at 14000000
>    Booting using the fdt blob at 0x14000000
>    Uncompressing Kernel Image ... OK
>    Loading Ramdisk to 1e923000, end 1fec423c ... OK
>    Loading Device Tree to 007fb000, end 007ff5a3 ... OK    *(some times
> it stucking here) *
> Using MPC86xx HPCN machine description
> Total memory = 512MB; using 1024kB for hash table (at cff00000)
> Linux version 3.13.6 (ashish@ashish-VirtualBox) (gcc version 4.7.2 (GCC)
> ) #8 Sat Mar 29 10:31:58 IST 2014
> Found initrd at 0xde923000:0xdfec423c
> bootconsole [udbg0] enabled
> setup_arch: bootmem
> mpc86xx_hpcn_setup_arch()
> MPC86xx HPCN board from Freescale Semiconductor
> arch: exit
> Zone ranges:
>   DMA      [mem 0x00000000-0x1fffffff]
>   Normal   empty
>   HighMem  empty
> Movable zone start for each node
> Early memory node ranges
>   node   0: [mem 0x00000000-0x1fffffff]         *(some times here) *
>
>
>

--001a11c33b02e6bd1604f862b4ac
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>Hello Ashish,<br><br></div>is this issue resolve=
d and is this always happening when you are changing core to 1Ghz because i=
 am confused here with sometime Keyword.<br><br></div>Regards<br>Sanjeev Sh=
arma<br>
</div><div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">On Fri,=
 Apr 4, 2014 at 1:12 PM, Ashish <span dir=3D"ltr">&lt;<a href=3D"mailto:cur=
ieux.khetan@gmail.com" target=3D"_blank">curieux.khetan@gmail.com</a>&gt;</=
span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
 =20
   =20
 =20
  <div bgcolor=3D"#FFFFFF" text=3D"#000000"><div><div class=3D"h5">
    <div>On Thursday 03 April 2014 08:55 AM,
      sanjeev sharma wrote:<br>
    </div>
    <blockquote type=3D"cite">
      <div dir=3D"ltr">
        <div>Are you able to capture kernel logs ?<br>
          <br>
        </div>
        Regards<br>
        Sanjeev Sharma<br>
      </div>
      <div class=3D"gmail_extra"><br>
        <br>
        <div class=3D"gmail_quote">On Thu, Mar 27, 2014 at 10:01 PM, <span =
dir=3D"ltr">&lt;<a href=3D"mailto:Valdis.Kletnieks@vt.edu" target=3D"_blank=
">Valdis.Kletnieks@vt.edu</a>&gt;</span>
          wrote:<br>
          <blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex">
            <div>On Thu, 27 Mar 2014 16:04:37 +0530, Ashish
              said:<br>
              &gt; Hi,<br>
              &gt;<br>
              &gt; =C2=A0 I am using MPC8641-HPCN based custom board and ab=
le
              to boot linux at<br>
              &gt; MPX clock 400Mhz and core clock 800mhz. When I am
              increasing core<br>
              &gt; frequency ie MPX clock at 400Mhz and core at 1Ghz,
              kernel stuck.<br>
              <br>
            </div>
            Step 0: =C2=A0Prove to us that your core actually runs reliable
            and stably at 1Ghz.<br>
            <br>
            Step 1: Figure out *where* it gets stuck. =C2=A0If you have
            earlyprintk working on<br>
            your board, adding &#39;initcall_debug ignore_loglevel&#39; to =
the
            kernel cmdline often<br>
            helps track down where a kernel hangs during boot.<br>
            <br>
            <br>
            _______________________________________________<br>
            Kernelnewbies mailing list<br>
            <a href=3D"mailto:Kernelnewbies@kernelnewbies.org" target=3D"_b=
lank">Kernelnewbies@kernelnewbies.org</a><br>
            <a href=3D"http://lists.kernelnewbies.org/mailman/listinfo/kern=
elnewbies" target=3D"_blank">http://lists.kernelnewbies.org/mailman/listinf=
o/kernelnewbies</a><br>
            <br>
          </blockquote>
        </div>
        <br>
      </div>
    </blockquote></div></div>
    Hi, <br>
    Does kernel logs means debugging information that kernel prints
    while booting using printk or it is something else?<br>
    Here is kernel boot logs that kernel printed while booting...<br>
    <br>
    U-Boot 2013.04 (Jan 27 2014 - 11:21:21)
<br>
    =C2=A0<br>
    Unicore software on multiprocessor system!!
<br>
    To enable mutlticore build define CONFIG_MP
<br>
    CPU:=C2=A0=C2=A0 8641, Version: 2.1, (0x80900021)
<br>
    Core:=C2=A0 E600 Core 0, Version: 2.2, (0x80040202)
<br>
    Clock Configuration:
<br>
    =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CPU:1000 MHz, MPX:400=C2=A0 MHz
<br>
    =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DDR:200=C2=A0 MHz (400 MT/s data r=
ate), LBC:25=C2=A0=C2=A0 MHz
<br>
    L1:=C2=A0=C2=A0=C2=A0 D-cache 32 KB enabled
<br>
    =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 I-cache 32 KB enabled
<br>
    L2:=C2=A0=C2=A0=C2=A0 512 KB enabled
<br>
    Board: MPC8641-HPCN<br>
    I2C:=C2=A0=C2=A0 ready
<br>
    DRAM:=C2=A0 512 MiB
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
    In:=C2=A0=C2=A0=C2=A0 serial
<br>
    Out:=C2=A0=C2=A0 serial
<br>
    Err:=C2=A0=C2=A0 serial
<br>
    Net:=C2=A0=C2=A0 eTSEC1, eTSEC2, eTSEC3, eTSEC4 [PRIME]
<br>
    Hit any key to stop autoboot: <br>
    Speed: 1000, full duplex
<br>
    Using eTSEC4 device
<br>
    TFTP from server 192.168.10.1; our IP address is 192.168.10.2
<br>
    Filename &#39;uRamdisk&#39;.
<br>
    Load address: 0x600000
<br>
    Loading:
    * #################################################################
<br>
    =C2=A0=C2=A0=C2=A0
    =C2=A0#################################################################
<br>
    =C2=A0=C2=A0=C2=A0
    =C2=A0#################################################################
<br>
    =C2=A0=C2=A0=C2=A0
    =C2=A0#################################################################
<br>
    =C2=A0=C2=A0=C2=A0
    =C2=A0#################################################################
<br>
    =C2=A0=C2=A0=C2=A0
    =C2=A0#################################################################
<br>
    =C2=A0=C2=A0=C2=A0
    =C2=A0#################################################################
<br>
    =C2=A0=C2=A0=C2=A0
    =C2=A0#################################################################
<br>
    =C2=A0=C2=A0=C2=A0
    =C2=A0#################################################################
<br>
    =C2=A0=C2=A0=C2=A0
    =C2=A0#################################################################
<br>
    =C2=A0=C2=A0=C2=A0
    =C2=A0#################################################################
<br>
    =C2=A0=C2=A0=C2=A0
    =C2=A0#################################################################
<br>
    =C2=A0=C2=A0=C2=A0
    =C2=A0#################################################################
<br>
    =C2=A0=C2=A0=C2=A0
    =C2=A0#################################################################
<br>
    =C2=A0=C2=A0=C2=A0
    =C2=A0#################################################################
<br>
    =C2=A0=C2=A0=C2=A0
    =C2=A0#################################################################
<br>
    =C2=A0=C2=A0=C2=A0
    =C2=A0#################################################################
<br>
    =C2=A0=C2=A0=C2=A0
    =C2=A0#################################################################
<br>
    =C2=A0=C2=A0=C2=A0
    =C2=A0#################################################################
<br>
    =C2=A0=C2=A0=C2=A0
    =C2=A0#################################################################
<br>
    =C2=A0=C2=A0=C2=A0
    =C2=A0#################################################################
<br>
    =C2=A0=C2=A0=C2=A0
    =C2=A0#################################################################
<br>
    =C2=A0=C2=A0=C2=A0
    =C2=A0#################################################################
<br>
    =C2=A0=C2=A0=C2=A0 =C2=A0##############################################=
####
<br>
    =C2=A0=C2=A0=C2=A0 =C2=A013.1 MiB/s
<br>
    done
<br>
    Bytes transferred =3D 22680188 (15a127c hex)
<br>
    Speed: 1000, full duplex
<br>
    Using eTSEC4 device
<br>
    TFTP from server 192.168.10.1; our IP address is 192.168.10.2
<br>
    Filename &#39;uImage&#39;.
<br>
    Load address: 0x16000000
<br>
    Loading:
    * #################################################################
<br>
    =C2=A0=C2=A0=C2=A0
    =C2=A0#################################################################
<br>
    =C2=A0=C2=A0=C2=A0 =C2=A0#######################################
<br>
    =C2=A0=C2=A0=C2=A0 =C2=A014 MiB/s
<br>
    done
<br>
    Bytes transferred =3D 2476304 (25c910 hex)
<br>
    Speed: 1000, full duplex
<br>
    Using eTSEC4 device
<br>
    TFTP from server 192.168.10.1; our IP address is 192.168.10.2
<br>
    Filename &#39;mpc8641_hpcn.dtb&#39;.
<br>
    Load address: 0x14000000
<br>
    Loading: * #
<br>
    =C2=A0=C2=A0=C2=A0 =C2=A02.6 MiB/s
<br>
    done
<br>
    Bytes transferred =3D 5540 (15a4 hex)
<br>
    ## Booting kernel from Legacy Image at 16000000 ...
<br>
    =C2=A0=C2=A0 Image Name:=C2=A0=C2=A0 Linux-3.13.6
<br>
    =C2=A0=C2=A0 Image Type:=C2=A0=C2=A0 PowerPC Linux Kernel Image (gzip c=
ompressed)
<br>
    =C2=A0=C2=A0 Data Size:=C2=A0=C2=A0=C2=A0 2476240 Bytes =3D 2.4 MiB
<br>
    =C2=A0=C2=A0 Load Address: 00000000
<br>
    =C2=A0=C2=A0 Entry Point:=C2=A0 00000000
<br>
    =C2=A0=C2=A0 Verifying Checksum ... OK
<br>
    ## Loading init Ramdisk from Legacy Image at 00600000 ...
<br>
    =C2=A0=C2=A0 Image Name:=C2=A0=C2=A0 rootfs
<br>
    =C2=A0=C2=A0 Image Type:=C2=A0=C2=A0 PowerPC Linux RAMDisk Image (gzip =
compressed)
<br>
    =C2=A0=C2=A0 Data Size:=C2=A0=C2=A0=C2=A0 22680124 Bytes =3D 21.6 MiB
<br>
    =C2=A0=C2=A0 Load Address: 00000000
<br>
    =C2=A0=C2=A0 Entry Point:=C2=A0 00000000
<br>
    =C2=A0=C2=A0 Verifying Checksum ... OK
<br>
    ## Flattened Device Tree blob at 14000000
<br>
    =C2=A0=C2=A0 Booting using the fdt blob at 0x14000000
<br>
    =C2=A0=C2=A0 Uncompressing Kernel Image ... OK
<br>
    =C2=A0=C2=A0 Loading Ramdisk to 1e923000, end 1fec423c ... OK
<br>
    =C2=A0=C2=A0 Loading Device Tree to 007fb000, end 007ff5a3 ... OK=C2=A0=
=C2=A0=C2=A0 <i><u><b>(some
          times it stucking here)
</b></u></i><br>
    Using MPC86xx HPCN machine description
<br>
    Total memory =3D 512MB; using 1024kB for hash table (at cff00000)
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
    =C2=A0 DMA=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [mem 0x00000000-0x1fffffff]
<br>
    =C2=A0 Normal=C2=A0=C2=A0 empty
<br>
    =C2=A0 HighMem=C2=A0 empty
<br>
    Movable zone start for each node
<br>
    Early memory node ranges
<br>
    =C2=A0 node=C2=A0=C2=A0 0: [mem 0x00000000-0x1fffffff]
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 <i><u><b>(some
          times here)
        </b></u></i><br>
    <br>
    <br>
  </div>

</blockquote></div><br></div>

--001a11c33b02e6bd1604f862b4ac--
