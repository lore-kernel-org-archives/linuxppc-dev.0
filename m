Return-Path: <nm127@freemail.hu>
Received: from relay02.digicable.hu (relay02.digicable.hu [92.249.128.188])
	by ozlabs.org (Postfix) with ESMTP id C97EAB7C67
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Mar 2010 17:54:24 +1100 (EST)
Message-ID: <4BB1A016.2050008@freemail.hu>
Date: Tue, 30 Mar 2010 08:54:14 +0200
From: =?windows-1252?Q?N=E9meth_M=E1rton?= <nm127@freemail.hu>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Freescale MPC5554 device tree (was: cross-compiling Linux for
	PowerPC e200 core?)
References: <4B934CCA.8030608@freemail.hu> <4B95458A.4000304@freemail.hu>
	<fa686aa41003081108v31e73660pa817863e5aa73653@mail.gmail.com>
	<4B95F298.5040000@freemail.hu>
	<fa686aa41003082335t5a5d642fi13c81e4b84f7b697@mail.gmail.com>
	<4B9889AC.4080309@freemail.hu> <20100311062331.GI11655@yookeroo>
	<4B99DE95.8010304@freemail.hu>
	<fa686aa41003120414j48825e7cr952336703fe03b04@mail.gmail.com>
	<4B9B7E0A.8090703@freemail.hu>
	<fa686aa41003171202p677bc14g25a6ac38f879ddf1@mail.gmail.com>
In-Reply-To: <fa686aa41003171202p677bc14g25a6ac38f879ddf1@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Cc: linuxppc-dev Development <linuxppc-dev@ozlabs.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

Grant Likely wrote:
> 2010/3/13 Németh Márton <nm127@freemail.hu>:
[...]
>> +                       };
>> +
>> +                       etpu@3fc0000 {          // Enhanced Time Processing Unit
>> +                               compatible = "fsl,mpc5554-etpu";
>> +                               reg = <0x03fc0000 0x4000>;
>> +                               interrupts = <67 1      // Global Exception
>> +                                             68 1      // A Channel 0
>> +                                             69 1      // A Channel 1
>> +                                             70 1      // A Channel 2
>> +                                             71 1      // A Channel 3
>> +                                             72 1      // A Channel 4
>> +                                             73 1      // A Channel 5
>> +                                             74 1      // A Channel 6
>> +                                             75 1      // A Channel 7
>> +                                             76 1      // A Channel 8
>> +                                             77 1      // A Channel 9
>> +                                             78 1      // A Channel 10
>> +                                             79 1      // A Channel 11
>> +                                             80 1      // A Channel 12
>> +                                             81 1      // A Channel 13
>> +                                             82 1      // A Channel 14
>> +                                             83 1      // A Channel 15
>> +                                             84 1      // A Channel 16
>> +                                             85 1      // A Channel 17
>> +                                             86 1      // A Channel 18
>> +                                             87 1      // A Channel 19
>> +                                             88 1      // A Channel 20
>> +                                             89 1      // A Channel 21
>> +                                             90 1      // A Channel 22
>> +                                             91 1      // A Channel 23
>> +                                             92 1      // A Channel 24
>> +                                             93 1      // A Channel 25
>> +                                             94 1      // A Channel 26
>> +                                             95 1      // A Channel 27
>> +                                             96 1      // A Channel 28
>> +                                             97 1      // A Channel 29
>> +                                             98 1      // A Channel 30
>> +                                             99 1      // A Channel 31
>> +                                             243 1     // B Channel 0
>> +                                             244 1     // B Channel 1
>> +                                             245 1     // B Channel 2
>> +                                             246 1     // B Channel 3
>> +                                             247 1     // B Channel 4
>> +                                             248 1     // B Channel 5
>> +                                             249 1     // B Channel 6
>> +                                             250 1     // B Channel 7
>> +                                             251 1     // B Channel 8
>> +                                             252 1     // B Channel 9
>> +                                             253 1     // B Channel 10
>> +                                             254 1     // B Channel 11
>> +                                             255 1     // B Channel 12
>> +                                             256 1     // B Channel 13
>> +                                             257 1     // B Channel 14
>> +                                             258 1     // B Channel 15
>> +                                             259 1     // B Channel 16
>> +                                             260 1     // B Channel 17
>> +                                             261 1     // B Channel 18
>> +                                             262 1     // B Channel 19
>> +                                             263 1     // B Channel 20
>> +                                             264 1     // B Channel 21
>> +                                             265 1     // B Channel 22
>> +                                             266 1     // B Channel 23
>> +                                             267 1     // B Channel 24
>> +                                             268 1     // B Channel 25
>> +                                             269 1     // B Channel 26
>> +                                             270 1     // B Channel 27
>> +                                             271 1     // B Channel 28
>> +                                             272 1     // B Channel 29
>> +                                             273 1     // B Channel 30
>> +                                             274 1>;   // B Channel 31
>
> Are A and B two instances of the same hardware block?  Consider having
> a subnode for each instance to give some logical separation to this
> list and associate register ranges with instances.  Doing it that way
> also makes it easier for external device nodes to describe an
> attachment to a particular channel.
>
>> +                       };
>> +
>> +                       etpudata@3fc8000 {      // eTPU Shared Data Memory (Parameter RAM)
>> +                               compatible = "fsl,mpc5554-etpudata";
>> +                               reg = <0x03fc8000 0x4000>;
>> +                       };
>> +
>> +                       etpudata@3fcc000 {      // eTPU Shared Data Memory (Parameter RAM) mirror
>> +                               compatible = "fsl,mpc5554-etpudata";
>> +                               reg = <0x03fcc000 0x4000>;
>> +                       };
>> +
>> +                       etpucode@3fd0000 {              // eTPU Shared Code RAM
>> +                               compatible = "fsl,mpc5554-etpucode";
>> +                               reg = <0x03fd0000 0x4000>;
>> +                       };
>
> Should all this etpu stuff be part of the etpu node?

With this version of MPC5554 device tree I try to improve the eTPU
related node. The Table 18-6 on page 18-15 in the
http://www.freescale.com/files/32bit/doc/ref_manual/MPC5553_MPC5554_RM.pdf
shows the detailed memory map of the eTPU. What is visible is that the
eTPU A and eTPU B is interleaved in the memory map. For example ETPU_ECR_A
is at Base + 0x0_0014 while ETPU_ECR_B is at Base + 0x0_0018. Then comes a
register set for time base configuration: ETPU_TBCR_A is at Base + 0x0_0020,
and ETPU_TBCR_B is at Base + 0x0_0040. As you can see the eTPU A and eTPU B
registers are not just shifted by a fixed offset but comes interleaved
according to the hardware designer wish.

How can the multiple register ranges be expressed in device tree?

Regards,

	Márton Németh

---
From: Márton Németh <nm127@freemail.hu>

Add device tree for Freescale MPC5554.

Signed-off-by: Márton Németh <nm127@freemail.hu>
---
diff -uprN linux-2.6.33.orig/arch/powerpc/boot/dts//mpc5554.dts linux-2.6.33/arch/powerpc/boot/dts/mpc5554.dts
--- linux-2.6.33.orig/arch/powerpc/boot/dts//mpc5554.dts	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.33/arch/powerpc/boot/dts/mpc5554.dts	2010-03-30 08:17:06.000000000 +0200
@@ -0,0 +1,321 @@
+/*
+ * Freescale MPC5554 Device Tree Source
+ *
+ * Based on MPC5553/5554 Microcontroller Reference Manual, Rev. 4.0, 04/2007
+ * http://www.freescale.com/files/32bit/doc/ref_manual/MPC5553_MPC5554_RM.pdf
+ *  - Block Diagram: page 1-3, Figure 1-1
+ *  - Memory Map: page 1-21, Table 1-2
+ *  - Interrupt Request Sources: page 10-16, Table 10-9
+ *
+ * This device tree also contains external components found on MPC5554DEMO
+ * http://www.axman.com/files/MPC5554DEMO_man_G.pdf
+ * http://www.axman.com/files/MPC5554DEMO_SCH_G.pdf
+ *
+ * Copyright 2010 Márton Németh
+ * Márton Németh <nm127@freemail.hu>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+/dts-v1/;
+
+/ {
+	model = "MPC5554";
+	compatible = "fsl,MPC5554EVB";		// Freescale MPC5554 Evaluation Board
+	#address-cells = <1>;
+	#size-cells = <1>;
+	interrupt-parent = <&intc>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu@0 {
+			device_type = "cpu";
+			compatible = "PowerPC,5554", "fsl,mpc5554-e200z6", "fsl,powerpc-e200z6";
+			reg = <0>;
+			d-cache-line-size = <32>;
+			i-cache-line-size = <32>;
+			d-cache-size = <0x8000>;	// L1, 32KiB
+			i-cache-size = <0x8000>;	// L1, 32KiB
+			timebase-frequency = <0>;	// from bootloader
+			bus-frequency = <0>;		// from bootloader
+			clock-frequency = <0>;		// from bootloader
+		};
+	};
+
+	memory@20000000 {
+		device_type = "memory";
+		reg = <0x20000000 0x80000>;	// 512KiB external SRAM: ISSI IS61SF12832
+		// CS0 or CS1 selectable by the SRAM_SEL jumper
+	};
+
+	xbar@fff04000 {		// System Bus Crossbar Switch (XBAR)
+		compatible = "fsl,mpc5554-xbar";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		// The full memory range is covered by XBAR
+		ranges;
+		reg = <0xfff04000 0x4000>;
+
+		flash@0 {	// read-only FLASH
+			compatible = "fsl,mpc5554-flash";
+			reg = <0x00000000 0x200000>;	// 2MiB internal FLASH
+		};
+
+		memory@40000000 {
+			compatible = "fsl,mpc5554-sram";
+			reg = <0x40000000 0x10000>;	// 64KiB internal SRAM
+		};
+
+		bridge@c3f00000 {
+			compatible = "fsl,mpc5554-pbridge-a";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0xc0000000 0x20000000>;
+			reg = <0xc3f00000 0x4000>;
+
+			fmpll@3f80000 {		// Frequency Modulated PLL
+				compatible = "fsl,mpc5554-fmpll";
+				reg = <0x03f80000 0x4000>;
+				interrupts = <43	// Loss of Clock
+					      44>;	// Loss of Lock
+			};
+
+			flashconfig@3f88000 {	// Flash Configuration
+				compatible = "fsl,mpc5554-flashconfig";
+				reg = <0x03f88000 0x4000>;
+			};
+
+			siuintc: siu@3f89000 {		// System Integration Unit
+				compatible = "fsl,mpc5554-siu";
+				reg = <0x03f90000 0x4000>;
+
+				// SIU is an interrupt controller by means that it handles
+				// the external interrupts
+				#interrupt-cells = <2>;   // cell 1: extirq#, cell 2: level/edge flags
+				interrupt-controller;
+				interrupts = <45 1	// External Interrupt Overrun 0-15
+					      46 1	// External Interrupt 0
+					      47 1	// External Interrupt 1
+					      48 1	// External Interrupt 2
+					      49 1	// External Interrupt 3
+					      50 1>;	// External Interrupt 4-15
+			};
+
+			emios@3fa0000 {		// Modular Timer System
+				compatible = "fsl,mpc5554-emios";
+				reg = <0x03fa0000 0x4000>;
+				interrupts = < 51  52  53  54  55  56  57  58	// Channels 0-7
+					       59  60  61  62  63  64  65  66	// Channels 8-15
+					      202 203 204 205 206 207 208 209>;	// Channel 16-23
+			};
+
+			etpu@3fc0000 {		// Enhanced Time Processing Unit
+				compatible = "fsl,mpc5554-etpu";
+				reg = <0x03fc0000 0x4000>;
+				interrupts = <67>;	// Global Exception
+
+				etpuengine@3fc0014 {	// eTPU Engine A
+					compatible = "fsl,mpc5554-etpuengine";
+					interrupts = <68 69 70 71 72 73 74 75	// A Channels 0-7
+						      76 77 78 79 80 81 82 83	// A Channels 8-15
+						      84 85 86 87 88 89 90 91	// A Channels 16-23
+						      92 93 94 95 96 97 98 99	// A Channels 24-31
+				};
+
+				etpuengine@3fc0018 {	// eTPU Engine B
+					compatible = "fsl,mpc5554-etpuengine";
+					interrupts = <243 244 245 256 247 248 249 250	// B Channels 0-7
+						      251 252 253 254 255 256 257 248	// B Channels 8-15
+						      259 260 261 262 263 264 265 266	// B Channels 16-23
+						      267 268 269 270 271 272 273 274>;	// B Channels 24-31
+				};
+
+				etpudata@3fc8000 {	// eTPU Shared Data Memory (Parameter RAM)
+					compatible = "fsl,mpc5554-etpudata";
+					reg = <0x03fc8000 0x4000>;	// 3 KiB
+				};
+
+				etpudata@3fcc000 {	// eTPU Shared Data Memory (Parameter RAM) mirror
+					compatible = "fsl,mpc5554-etpudata";
+					reg = <0x03fcc000 0x4000>;	// 3 KiB
+				};
+
+				etpucode@3fd0000 {		// eTPU Shared Code RAM
+					compatible = "fsl,mpc5554-etpucode";
+					reg = <0x03fd0000 0x4000>;	// 16 KiB
+				};
+			};
+		};
+
+		bridge@fff00000 {
+			compatible = "fsl,mpc5554-pbridge-b";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0xe0000000 0x20000000>;
+			reg = <0xfff00000 0x4000>;
+
+			ecsm@fff40000 {		// Error Correction Status Module (ECSM)
+				compatible = "fsl,mpc5554-ecsm";
+				reg = <0xfff40000 0x4000>;
+				interrupts = <8	// Software Watchdog Interrupt
+					      9>;	// Combined: Internal SRAM Non-Correctable Error, Flash Non-Correctable Error
+			};
+
+			edma@fff44000 {		// Enhanced DMA Controller (eDMA)
+				compatible = "fsl,mpc5554-edma";
+				reg = <0xfff44000 0x4000>;
+				interrupts = <10				// Channel Error 0-31
+					      11 12 13 14 15 16 17 18		// Channels 0-7
+					      19 20 21 22 23 24 25 26		// Channels 8-15
+					      27 28 29 30 31 32 33 34		// Channels 16-23
+					      35 36 37 38 39 40 41 42		// Channels 24-31
+					      210				// Channel Error 32-63
+					      211 212 213 214 215 216 217 218	// Channels 32-39
+					      219 220 221 222 223 224 225 226	// Channels 40-47
+					      227 228 229 230 231 232 233 234	// Channels 48-55
+					      235 236 237 238 239 240 241 242>;	// Channels 56-63
+			};
+
+			intc: intc@fff48000 {		// Interrupt Controller (INTC)
+				compatible = "fsl,mpc5554-intc";
+				interrupt-controller;
+				#interrupt-cells = <1>;
+				reg = <0xfff48000 0x4000>;
+			};
+
+			eqadc@fff80000 {	// Enhanced Queued Analog-to-Digital Converter (eQADC)
+				compatible = "fsl,mpc5554-eqacd";
+				reg = <0xfff80000 0x4000>;
+				interrupts = <100	// Combined: Trigger Overrun, Receive FIFO Overflow, Command FIFO Underflow
+					      101	// Command FIFO 0 Non-Coherency
+					      102	// Command FIFO 0 Pause
+					      103	// Command FIFO 0 End of Queue
+					      104	// Command FIFO 0 Fill
+					      105	// Command FIFO 0 Drain
+					      106	// Command FIFO 1 Non-Coherency
+					      107	// Command FIFO 1 Pause
+					      108	// Command FIFO 1 End of Queue
+					      109	// Command FIFO 1 Fill
+					      111	// Command FIFO 1 Drain
+					      111	// Command FIFO 2 Non-Coherency
+					      112	// Command FIFO 2 Pause
+					      113	// Command FIFO 2 End of Queue
+					      114	// Command FIFO 2 Fill
+					      115	// Command FIFO 2 Drain
+					      116	// Command FIFO 3 Non-Coherency
+					      117	// Command FIFO 3 Pause
+					      118	// Command FIFO 3 End of Queue
+					      119	// Command FIFO 3 Fill
+					      120	// Command FIFO 3 Drain
+					      121	// Command FIFO 4 Non-Coherency
+					      122	// Command FIFO 4 Pause
+					      123	// Command FIFO 4 End of Queue
+					      124	// Command FIFO 4 Fill
+					      125	// Command FIFO 4 Drain
+					      126	// Command FIFO 5 Non-Coherency
+					      127	// Command FIFO 5 Pause
+					      128	// Command FIFO 5 End of Queue
+					      129	// Command FIFO 5 Fill
+					      130>;	// Command FIFO 5 Drain
+			};
+
+			dspi@fff90000 {		// Deserial Serial Peripheral Interface (DSPI_A)
+				compatible = "fsl,mpc5554-dspi";
+				reg = <0xfff90000 0x4000>;
+				interrupts = <275	// Combined: Transmit FIFO Underflow, Receive FIFO Overflow
+					      276	// Transmit FIFO End of Queue
+					      277	// Transmit FIFO Fill Flag
+					      278	// Transfer Complete
+					      279>;	// Receive FIFO Drain
+			};
+
+			dspi@fff94000 {		// Deserial Serial Peripheral Interface (DSPI_B)
+				compatible = "fsl,mpc5554-dspi";
+				reg = <0xfff94000 0x4000>;
+				interrupts = <131	// Combined: Transmit FIFO Underflow, Receive FIFO Overflow
+					      132	// Transmit FIFO End of Queue
+					      133	// Transmit FIFO Fill Flag
+					      134	// Transfer Complete
+					      135>;	// Receive FIFO Drain
+			};
+
+			dspi@fff98000 {		// Deserial Serial Peripheral Interface (DSPI_C)
+				compatible = "fsl,mpc5554-dspi";
+				reg = <0xfff98000 0x4000>;
+				interrupts = <136	// Combined: Transmit FIFO Underflow, Receive FIFO Overflow
+					      137	// Transmit FIFO End of Queue
+					      138	// Transmit FIFO Fill Flag
+					      139	// Transfer Complete
+					      140>;	// Receive FIFO Drain
+			};
+
+			dspi@fff9c000 {		// Deserial Serial Peripheral Interface (DSPI_D)
+				compatible = "fsl,mpc5554-dspi";
+				reg = <0xfff9c000 0x4000>;
+				interrupts = <141	// Combined: Transmit FIFO Underflow, Receive FIFO Overflow
+					      142	// Transmit FIFO End of Queue
+					      143	// Transmit FIFO Fill Flag
+					      144	// Transfer Complete
+					      145>;	// Receive FIFO Drain
+			};
+
+			esci@fffb0000 {		// Serial Communications Interface (SCI_A)
+				compatible = "fsl,mpc5554-esci";
+				reg = <0xfffb0000 0x4000>;
+				interrupts = <146>;	// Combined request for all SCI_A interrupts
+			};
+
+			esci@fffb4000 {		// Serial Communications Interface (SCI_B)
+				compatible = "fsl,mpc5554-esci";
+				reg = <0xfffb4000 0x4000>;
+				interrupts = <149>;	// Combined request for all SCI_A interrupts
+			};
+
+			can@fffc0000 {		// Controller Area Network (FlexCAN_A)
+				compatible = "fsl,mpc5554-flexcan";
+				reg = <0xfffc0000 0x4000>;
+				interrupts = <152				// Bus off
+					      153				// Error
+					      155 156 157 158 159 160 161 162	// Buffers 0-7
+					      163 164 165 166 167 168 169 170	// Buffers 8-15
+					      171				// Buffers 16-31
+					      172>;				// Buffers 32-63
+			};
+
+			can@fffc4000 {		// Controller Area Network (FlexCAN_B)
+				compatible = "fsl,mpc5554-flexcan";
+				reg = <0xfffc4000 0x4000>;
+				interrupts = <280				// Bus off
+					      281				// Error
+					      283 284 285 186 287 288 289 290	// Buffers 0-7
+					      291 292 293 294 295 296 297 298	// Buffers 8-15
+					      299				// Buffers 16-31
+					      300>;				// Buffers 32-63
+			};
+
+			can@fffc8000 {		// Controller Area Network (FlexCAN_C)
+				compatible = "fsl,mpc5554-flexcan";
+				reg = <0xfffc8000 0x4000>;
+				interrupts = <173				// Bus off
+					      174				// Error
+					      176 177 178 179 180 181 182 183	// Buffers 0-7
+					      184 185 186 187 188 189 190 191	// Buffers 8-15
+					      192				// Buffers 16-31
+					      193>;				// Buffers 32-63
+			};
+
+			bam@ffffc000 {		// Boot Assist Module (BAM)
+				compatible = "fsl,mpc5554-bam";
+				reg = <0xffffc000 0x4000>;
+			};
+
+		};
+
+	};
+
+};
