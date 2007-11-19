Return-Path: <guojin02@tsinghua.org.cn>
Received: from tsinghua.org.cn (mail.tsinghua.org.cn [210.77.143.232])
	by ozlabs.org (Postfix) with SMTP id 4C094DDE08
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 Nov 2007 02:00:35 +1100 (EST)
Message-ID: <395483341.30896@tsinghua.org.cn>
From: "=?gb2312?B?ufm+og==?=" <guojin02@tsinghua.org.cn>
To: linuxppc-embedded@ozlabs.org
Date: Mon, 19 Nov 2007 22:42:21 +0800
Subject: How can I make the DDR momory storage bigger than 256M?
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

I used the U-Boot 1.2.0 on MPC8360E board. My board work nomally with 256M DDR-1
Memory.  If I change the DDR-1 up to 1GB, the U-Boot can visit the DDR address
range from 0x00000000 to 0x10000000, but it can not visit the address bigger than
0x10000000,I wat wondering why? Thanks.

Using the 1GB DDR-1, I can write the u-boot to my flash by CodeWarrior.

Follow is the information that when I test the DDR on u-boot, the start address is
0x1ff00000, the end address is 0x20000000;it was dead when visit the DDR.






U-Boot 1.2.0 (Nov 19 2007 - 20:55:34) MPC83XX                                 
                                                                              
CPU:   e300c1, MPC8360E, Rev: 20 at 528 MHz, CSB:  264 MHz                    
Board: Freescale MPC8360EMDS                                                  
I2C:   ready                                                                  
DRAM:                                                                         
DIMM type:                                                                    
SPD size:        128                                                          
EEPROM size:     256                                                          
Memory type:     7                                                            
Row addr:        13                                                           
Column addr:     11                                                           
# of rows:       2                                                            
Row density:     128                                                          
# of banks:      4                                                            
Data width:      64                                                           
Chip width:      8                                                            
Refresh rate:    82                                                           
CAS latencies:   18                                                           
Write latencies: 02                                                           
tRP:             60                                                           
tRCD:            60                                                           
                                                                              
                                                                              
cs0_bnds = 0x0000001f                                                         
cs0_config = 0x80000103                                                       
cs1_bnds = 0x0020003f                                                         
cs1_config = 0x80000103                                                       
DDR:bar=0x00000000                                                            
DDR:ar=0x8000001d                                                             
DDR: caslat SPD bit is 4                                                      
DDR:Module maximum data rate is: 400Mhz                                       
DDR:Effective data rate is: 266Mhz                                            
DDR:The MSB 1 of CAS Latency is: 4                                            
DDR: effective data rate is 266 MHz                                           
DDR: caslat SPD bit is 4, controller field is 0x5                             
DDR:timing_cfg_1=0x26252727                                                   
DDR:timing_cfg_2=0x00004841                                                   
                                                                              
   DDR DIMM: data bus width is 64 bit without ECC                             
DDR:sdram_mode=0x00000032                                                     
DDR: sdram_mode2 = 0x00000000                                                 
DDR:sdram_interval=0x04060100                                                 
DDR:sdram_clk_cntl=0x02000000                                                 
   DDRC ECC mode: OFF                                                         
DDR:sdram_cfg=0xc2008000                                                      
                                                                              
   SDRAM on Local Bus: 64 MB                                                  
   DDR RAM: 1024 MB                                                           
DDR test phase 1:              


(dead)
