Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: kingseft@samsung.co.kr
Date: Mon, 12 Mar 2001 10:42:00 +0900
Message-Id: <H00002af04ab19e3@MHS>
Subject: [QuestionIP_CONFIG : incomplete network configration info...
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


 Hi all developers.
 I ported ppcboot, linux kernel and ramdisk.
 when I boot kernel and ramdisk I got this message..

 IP_CONFIG: Incomplete network configuration info
 dev_cluse: bug eth0 still running....

 but I got linux shell. and all linux function worked fine......
 I use ppcboot and HardHat Linux kernel 2.2.14
 following list is myboard_config.h


#define	CONFIG_ETHADDR		08:00:30:31:32:33		/* Ethernet address 	*/
#define	CONFIG_IPADDR		  55.121.204.131			/* Target IP address 	*/
#define	CONFIG_SERVERIP		55.121.204.174				/* Servier IP address 	*/
#define CONFIG_BOOTDELAY	5	/* autoboot after 5 seconds		*

#define CONFIG_BOOTCOMMAND							\
"bootp ;" 									\
"setenv bootargs console=tty0 console=ttyS0 " 					\
"root=/dev/nfs nfsroot=$(serverip):$(rootpath) " 				\
"ip=$(ipaddr):$(serverip):$(gatewayip):$(netmask):$(hostname):eth0:off ;" 	\
"bootm"


 I think CONFIG_BOOTCOMMAND is imcomplte.
 Could someone describe how to use this BOOTCOMMAND for booting with ramdisk
 any comments will help me.. thanks.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
