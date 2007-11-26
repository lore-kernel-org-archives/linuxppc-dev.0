Return-Path: <guojin02@tsinghua.org.cn>
Received: from tsinghua.org.cn (unknown [210.77.143.232])
	by ozlabs.org (Postfix) with SMTP id 91CAFDDE36
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 26 Nov 2007 15:05:41 +1100 (EST)
Message-ID: <396048835.09329@tsinghua.org.cn>
From: "=?gb2312?B?ufm+og==?=" <guojin02@tsinghua.org.cn>
To: linuxppc-embedded@ozlabs.org
Date: Mon, 26 Nov 2007 11:47:15 +0800
Subject: The question about the UART on UCC5,UCC6,UCC7,UCC8 for MPC8360?
Content-Type: text/plain
Reply-To: =?gb2312?B?ufm+og==?= <guojin02@tsinghua.org.cn>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi,friends,

 I runed the LTIB for MPC8360,selected "configure the kernel", then the make
menuconfig is appeared,that is "linux kernel configuration". I config QE to
follow
style: 
UCC1,GETH;
UCC2,GETH; 
UCC5,UART;
UCC6,UART;
UCC7,UART;
UCC8,UART. 

  after compiled, I download the linux to MPC8360 board, but I cannot find the
serial device for UCC5,UCC6,UCC7,UCC8. I just find the ttyS0,ttyS1 is OK.
  Could you tell me that what's the name for the serial device of UCC5,6,7,8?
  Whether or not I can use those UART just like the ttyS0,ttyS1?



>Follow is the device name in linux for MPC8360.
>/dev # ls
>audio      hdb5       mtdblock4  ram2       sdc3       tty6       ttyp0
>audio1     hdb6       mtdblock5  ram3       sdc4       tty7       ttyp1
>buttons    hdb7       mtdblock6  random     sdc5       ttyAM0     ttyp2
>console    input      net        rtc        sdc6       ttyAM1     ttyp3
>dsp        kmem       null       sda        sdc7       ttyAM2     ttyp4
>dsp1       loop0      ppp        sda1       sdd        ttyAM3     ttyp5
>fb0        loop1      psaux      sda2       sdd1       ttyCPM0    ttyp6         
>fb1        md0        ptmx       sda3       sdd2       ttyCPM1    ttyp7         
>fb2        md1        pts        sda4       sdd3       ttyP0      ttyp8         
>fb3        md2        ptyp0      sda5       sdd4       ttyP1      ttyp9         
>hda        md3        ptyp1      sda6       sdd5       ttyP2      ubda          
>hda1       mem        ptyp2      sda7       sdd6       ttyP3      ubda1         
>hda2       mtd0       ptyp3      sdb        sdd7       ttyPSC0    ubda2         
>hda3       mtd1       ptyp4      sdb1       shm        ttyPSC1    ubda3         
>hda4       mtd2       ptyp5      sdb2       sndstat    ttyPSC2    ubda4         
>hda5       mtd3       ptyp6      sdb3       ts         ttyPSC3    ubda5         
>hda6       mtd4       ptyp7      sdb4       tty        ttyPSC4    ubda6         
>hda7       mtd5       ptyp8      sdb5       tty0       ttyPSC5    ubda7         
>hdb        mtd6       ptyp9      sdb6       tty1       ttyS0      urandom       
>hdb1       mtdblock0  qspi       sdb7       tty2       ttyS1      watchdog      
>hdb2       mtdblock1  ram        sdc        tty3       ttyS2      zero          
>hdb3       mtdblock2  ram0       sdc1       tty4       ttyS3                    
>hdb4       mtdblock3  ram1       sdc2       tty5       ttymxc0                  
>/dev # cat ttyS0                                                                
>                                                                                
>/dev # cat ttyS1                                                                
>                                                                                
>/dev # cat ttyS2                                                                
>cat: ttyS2: No such device or address                                           
>/dev # cat ttyPSC0                                                              
>cat: ttyPSC0: No such device or address                                         
>/dev # cat ttyP0                                                                
>cat: ttyP0: No such device or address                                           
>/dev # cat ttyp0                                                                
>cat: ttyp0: Input/output error                                                  
>/dev # cat ttyAM0
>cat: ttyAM0: No such device or address
>/dev # cat ttyCPM0
>cat: ttyCPM0: No such device or address
>/dev # 
