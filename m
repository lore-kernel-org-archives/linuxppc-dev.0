Return-Path: <jiehanca@yahoo.com.cn>
Received: from web15110.mail.cnb.yahoo.com (web15110.mail.cnb.yahoo.com
	[202.165.103.79]) by ozlabs.org (Postfix) with SMTP id B76D567A3A
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Aug 2006 13:31:05 +1000 (EST)
Message-ID: <20060816032420.3004.qmail@web15110.mail.cnb.yahoo.com>
Date: Tue, 15 Aug 2006 20:24:19 -0700 (PDT)
From: jie han <jiehanca@yahoo.com.cn>
Subject: hoe to define CPM_MAP_ADDR ?
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1898329840-1155698659=:2661"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-1898329840-1155698659=:2661
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit


I am trying to take a working embedded linux system from kernel 2.4 to 
2.6. The hardware is a custom board using a MPC8270 processor.
The working system uses u-boot 1.1.1 with linux kernel 2.4.24.
I am using the same u-boot and I am trying to port linux kernel 2.6.15 
to our platform. I just wonder hwo to define CPM_MAP_ADDR to my config file
at /arch/ppc/platforms/olt8270.h,thsi show file context as follow

#ifndef __OLT8270_PLATFORM
#define __OLT8270_PLATFORM

//#define CPM_MAP_ADDR  ((uint)0xf0000000)
#define IMAP_ADDR  ((uint)0xf0000000)

#define BOOTROM_RESTART_ADDR ((uint)0xfff00100)

/* For our show_cpuinfo hooks. */
#define CPUINFO_VENDOR  "Ocean Broadband Ltd"
#define CPUINFO_MACHINE  "OLT8270 PowerPC"

/* A Board Information structure that is given to a program when
 * prom starts it up.
 */
typedef struct bd_info {
 unsigned long bi_memstart; /* Memory start address */
 unsigned long bi_memsize;     /* Memory (end) size in bytes */
 unsigned long bi_flashstart; /* start of FLASH memory */
 unsigned long bi_flashsize; /* size  of FLASH memory */
 unsigned long bi_flashoffset; /* reserved area for startup monitor */
    unsigned long   bi_sramstart;   /* start of SRAM memory */
    unsigned long   bi_sramsize;    /* size of SRAM memory */

 unsigned long bi_immr;     /* IMMR when called from boot rom */

 unsigned long   bi_bootflags;   /* boot flag (for Lynx OS) */

 unsigned long   bi_ip_addr;     /* IP Address */
 unsigned char   bi_enetaddr[6]; /* Ethernet address */
 unsigned short  bi_ethspeed;    /* Ethernet speed in Mbps */

 unsigned long bi_intfreq;     /* Internal Freq, in Hz */
 unsigned long bi_busfreq;     /* Bus Freq, in MHz */
 unsigned long bi_cpmfreq;     /* CPM Freq, in MHz */
 unsigned long bi_brgfreq;     /* BRG Freq, in MHz */
 unsigned long bi_sccfreq;     /* SCC Freq, in MHz */
 unsigned long bi_vco;      /* VCO Out from PLL */
 unsigned long bi_baudrate; /* Default console baud rate */
} bd_t;

extern bd_t m8xx_board_info;

#endif  /* __OLT8270_PLATFORM */



Sincerely,


Jie


 		
---------------------------------
Talk is cheap. Use Yahoo! Messenger to make PC-to-Phone calls.  Great rates starting at 1¢/min.
--0-1898329840-1155698659=:2661
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<pre>I am trying to take a working embedded linux system from kernel 2.4 to <br>2.6. The hardware is a custom board using a MPC8270 processor.<br>The working system uses u-boot 1.1.1 with linux kernel 2.4.24.<br>I am using the same u-boot and I am trying to port linux kernel 2.6.15 <br>to our platform. I just wonder hwo to define CPM_MAP_ADDR to my config file<br>at /arch/ppc/platforms/olt8270.h,thsi show file context as follow<br><br>#ifndef __OLT8270_PLATFORM<br>#define __OLT8270_PLATFORM<br><br>//#define CPM_MAP_ADDR  ((uint)0xf0000000)<br>#define IMAP_ADDR  ((uint)0xf0000000)<br><br>#define BOOTROM_RESTART_ADDR ((uint)0xfff00100)<br><br>/* For our show_cpuinfo hooks. */<br>#define CPUINFO_VENDOR  "Ocean Broadband Ltd"<br>#define CPUINFO_MACHINE  "OLT8270 PowerPC"<br><br>/* A Board Information structure that is given to a program when<br> * prom starts it up.<br> */<br>typedef struct bd_info {<br> unsigned long bi_memstart; /* Memory start address */<br> unsigned long
 bi_memsize;     /* Memory (end) size in bytes */<br> unsigned long bi_flashstart; /* start of FLASH memory */<br> unsigned long bi_flashsize; /* size  of FLASH memory */<br> unsigned long bi_flashoffset; /* reserved area for startup monitor */<br>    unsigned long   bi_sramstart;   /* start of SRAM memory */<br>    unsigned long   bi_sramsize;    /* size of SRAM memory */<br><br> unsigned long bi_immr;     /* IMMR when called from boot rom */<br><br> unsigned long   bi_bootflags;   /* boot flag (for Lynx OS) */<br><br> unsigned long   bi_ip_addr;     /* IP Address */<br> unsigned char   bi_enetaddr[6]; /* Ethernet address */<br> unsigned short  bi_ethspeed;    /* Ethernet speed in Mbps */<br><br> unsigned long bi_intfreq;     /* Internal Freq, in Hz */<br> unsigned long bi_busfreq;     /* Bus Freq, in MHz */<br> unsigned long bi_cpmfreq;     /* CPM Freq, in MHz */<br> unsigned long bi_brgfreq;     /* BRG Freq, in MHz */<br> unsigned long bi_sccfreq;     /* SCC Freq, in MHz
 */<br> unsigned long bi_vco;      /* VCO Out from PLL */<br> unsigned long bi_baudrate; /* Default console baud rate */<br>} bd_t;<br><br>extern bd_t m8xx_board_info;<br><br>#endif  /* __OLT8270_PLATFORM */<br><br><br><br>Sincerely,<br><br><br>Jie<br></pre><p>&#32;
		<hr size=1>Talk is cheap. Use Yahoo! Messenger to make PC-to-Phone calls. <a href="http://us.rd.yahoo.com/mail_us/taglines/postman7/*http://us.rd.yahoo.com/evt=39666/*http://messenger.yahoo.com"> Great rates starting at 1¢/min.
--0-1898329840-1155698659=:2661--
