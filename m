Return-Path: <arun.coral@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.231])
	by ozlabs.org (Postfix) with ESMTP id 6B502DDD01
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Feb 2009 20:19:48 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id l9so1380850rvb.9
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Feb 2009 01:19:46 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <bb70857e0902130327u27fe4a4lcf743e08e66571c6@mail.gmail.com>
References: <bb70857e0902130327u27fe4a4lcf743e08e66571c6@mail.gmail.com>
Date: Mon, 16 Feb 2009 14:49:46 +0530
Message-ID: <bb70857e0902160119m318eaee6l39066c3b63e8a960@mail.gmail.com>
Subject: registered SORDIMM MT9HTF6472RHY-667F1
From: arun sharma <arun.coral@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: multipart/alternative; boundary=000e0cd1d5060e8702046305b026
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--000e0cd1d5060e8702046305b026
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

i am using mpc8360 emds board.
it is working fine with socdimm.

but with sordimm not working.

there is minor change i have done it for sordimm as follows for testing
only.
/* sdram_cfg[3] = RD_EN - registered DIMM enable */
// if (spd.mod_attr & 0x02) vivek
// {
printf("sdramcfg[3] registered DIMM\n");
sdram_cfg |= SDRAM_CFG_RD_EN;
// }



//#if defined(CONFIG_DDR_2T_TIMING) vivek
/*
* Enable 2T timing by setting sdram_cfg[16].
*/
// sdram_cfg |= SDRAM_CFG_2T_EN;
//#endif

i have enabled spd_debug and check the configuration.

CPU:   e300c1, MPC8358_TBGA_EA, Rev: 2.1 at 396 MHz, CSB: 198 MHz
Board: Freescale MPC8360EMDS
I2C:   ready
DRAM:
DIMM type:       9HTF6472RHY-667F1
SPD size:        128
EEPROM size:     256
Memory type:     8
Row addr:        14
Column addr:     10
# of rows:       96
Row density:     128
# of banks:      4
Data width:      72
Chip width:      8
Refresh rate:    82
CAS latencies:   38
Write latencies: 04
tRP:             60
tRCD:            60


cs0_bnds = 0x0000001f
cs0_config = 0x80010202
DDR:bar=0x00000000
DDR:ar=0x8000001c
DDR: caslat SPD bit is 5
DDR:Module maximum data rate is: 666 MHz
DDR:Effective data rate is: 200MHz
DDR:The MSB 1 of CAS Latency is: 5
DDR: effective data rate is 200 MHz
DDR: caslat SPD bit is 5, controller field is 0x9
DDR: timing_cfg_0 = 0x00260802
DDR:timing_cfg_1=0x25293211
DDR:timing_cfg_2=0x0fa028c4

   DDR DIMM: data bus width is 64 bit with ECC
DDR:sdram_mode=0x04400252
DDR: sdram_mode2 = 0x00000000
DDR:sdram_interval=0x03050100
DDR: sdram_cfg2  = 0x00401000
DDR:sdram_clk_cntl=0x02000000
sdramcfg[3] registered DIMM
DDR:err_disable=0x0000000d
DDR:err_sbe=0x00ff0000
   DDRC ECC mode: ON
DDR:sdram_cfg=0xf3000000
ddr init: CPU FP write method

READY!!
ddr init duration: 2090 ms
512 MB (DDR2, 64-bit, ECC on, 198 MHz)
Testing DRAM from 0x00000000 to 0x00200000
DRAM test phase 1:
write done
DRAM test phase 2:
DRAM test passed.

regards

--000e0cd1d5060e8702046305b026
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<br><br><div class="gmail_quote">i am using mpc8360 emds board.<br>it is working fine with socdimm.<br><br>but with sordimm not working.<br><br>there is minor change i have done it for sordimm as follows for testing only.<br>
/* sdram_cfg[3] = RD_EN - registered DIMM enable */<br>
// if (spd.mod_attr &amp; 
0x02) vivek<br>// {<br>printf(&quot;sdramcfg[3] registered DIMM\n&quot;);<br>sdram_cfg |= 
SDRAM_CFG_RD_EN;<br>// }<br><br><br><br>//#if defined(CONFIG_DDR_2T_TIMING) 
vivek<br>/*<br>* Enable 2T timing by setting sdram_cfg[16].<br>*/<br>// 
sdram_cfg |= SDRAM_CFG_2T_EN; <br>//#endif<br><br>i have enabled spd_debug and check the configuration.<br><br>CPU:&nbsp;&nbsp; e300c1, MPC8358_TBGA_EA, Rev: 2.1 at 396 MHz, CSB: 198 MHz<br>Board: 
Freescale MPC8360EMDS<br>I2C:&nbsp;&nbsp; ready<br>DRAM:&nbsp; <br>DIMM type:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
9HTF6472RHY-667F1 <br>SPD size:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 128<br>EEPROM size:&nbsp;&nbsp;&nbsp;&nbsp; 256<br>Memory 
type:&nbsp;&nbsp;&nbsp;&nbsp; 8<br>Row addr:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 14<br>Column addr:&nbsp;&nbsp;&nbsp;&nbsp; 10<br># of rows:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
96<br>Row density:&nbsp;&nbsp;&nbsp;&nbsp; 128<br># of banks:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4<br>Data width:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 72<br>Chip 
width:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8<br>Refresh rate:&nbsp;&nbsp;&nbsp; 82<br>CAS latencies:&nbsp;&nbsp; 38<br>Write latencies: 
04<br>tRP:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 60<br>tRCD:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 60<br><br><br>cs0_bnds = 
0x0000001f<br>cs0_config = 
0x80010202<br>DDR:bar=0x00000000<br>DDR:ar=0x8000001c<br>DDR: caslat SPD bit is 
5<br>DDR:Module maximum data rate is: 666 MHz<br>DDR:Effective data rate is: 
200MHz<br>DDR:The MSB 1 of CAS Latency is: 5<br>DDR: effective data rate is 200 
MHz<br>DDR: caslat SPD bit is 5, controller field is 0x9<br>DDR: timing_cfg_0 = 
0x00260802<br>DDR:timing_cfg_1=0x25293211<br>DDR:timing_cfg_2=0x0fa028c4<br><br>&nbsp;&nbsp; 
DDR DIMM: data bus width is 64 bit with ECC<br>DDR:sdram_mode=0x04400252<br>DDR: 
sdram_mode2 = 0x00000000<br>DDR:sdram_interval=0x03050100<br>DDR: sdram_cfg2&nbsp; = 
0x00401000<br>DDR:sdram_clk_cntl=0x02000000<br>sdramcfg[3] registered 
DIMM<br>DDR:err_disable=0x0000000d<br>DDR:err_sbe=0x00ff0000<br>&nbsp;&nbsp; DDRC ECC 
mode: ON<br>DDR:sdram_cfg=0xf3000000<br>ddr init: CPU FP write 
method<br><br>READY!!<br>ddr init duration: 2090 ms<br>512 MB (DDR2, 64-bit, ECC 
on, 198 MHz)<br>Testing DRAM from 0x00000000 to 0x00200000<br>DRAM test phase 
1:<br>write done<br>DRAM test phase 2:<br>DRAM test 
passed.<br><br>regards<br><br>
</div><br>

--000e0cd1d5060e8702046305b026--
