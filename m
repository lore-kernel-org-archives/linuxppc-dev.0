Message-ID: <009501bfb2c1$304406a0$1952df8d@SOYANG>
From: "???" <tachyon@postech.ac.kr>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: 8xxrom and fads rom questions.
Date: Mon, 1 May 2000 01:28:58 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello.

My name is Cha.

I'm a newbie in this area, working on porting of  linuxppc-embedded to HD860 board from http://www.headtel.com

Since I planned to use 8xxrom-0.3.0 as a bootloader, I read lots of pdf files related to MPC860 and FADS board.

After digging into 8xxrom code, I have many questions as follows.

--- Questions START.
1. What's the baud rate and serial port configurations of 8xxrom?

2. What's the meaning of ROMLOAD and DATA macros inf 8xxrom-0.3.0/Make.config

3. If ROMLOAD is base address of Flash ROM of FADS board why the value is 0xFE000000 neverthless the memory map of FADS board is as follows:

/* Memory map of FADS board from FADS user's manual
0x00000000 ~ : DRAM SIMM
0x02000000 ~ : Empty Space
0x02100000 ~ : BCSR~
0x02108000 ~ : Empty Space
0x02200000 ~ : MPC Internal MAP
0x02208000 ~ : Empty Space
0x02800000 ~ : Flash SIMM
0x03000000 ~ : SDRAM
0x03400000 ~ 0xFFFFFFFF : Empty Space
*/

4. I've found the sequence of image converting process is like that:

/* Image converting sequence of 8xxrom from Makefile
---> 8xxrom -> 8xxrom.elf -> 8xxrom.elf.s19
              |
               `----> 8xxrom.bin -> 8xxrom.bin.s19
*/

What's the difference between 8xxrom and 8xxrom.elf? (the disassemble result is same)
What's the difference between 8xxrom.bin and 8xxrom.elf?
Is bintos19 different from "powerpc-linux-objcopy -O srec" command?
Is mkrombin different from "powerpc-linux-objcopy -O binary" command?

5. Are there any documentation or README file for 8xrom or fads rom?
--- Questions END.


If these questions do not match with the subject of this mailing list, I'll apologize.

I'm sorry about my humble english. ;-)

Thanks in advance.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
