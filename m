Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: "Juan Padron" <j_padron@joseane.zzn.com>
Message-Id: <C398751347F4533458DB3F93154AAAFD@j_padron.joseane.zzn.com>
Date: Thu, 15 Nov 2001 10:43:18 +0100
Content-Type: text/plain; charset=iso-8859-1
To: linuxppc-embedded@lists.linuxppc.org
Subject: CONFIG_IDE_PCCARD or  CONFIG_IDE_PCMCIA
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


  Hi:

  I need to put and IDE disk through the PCMCIA port in an MPC823FADS. I use the ppcboot 1.0.0
I read the mailing list and i have a doubt: What is the diference between the IDE_PCCARD and the IDE_PCMCIA? What do i need to use?
  This is the PCMCIA stuff configuration of an config_TQM823L.h (¿is it the same i need to include on my config_FADS823.h?)


   #define CFG_PCMCIA_MEM_ADDR	   (0xE0000000)
   #define CFG_PCMCIA_MEM_SIZE	   ( 64 << 20 )
   #define CFG_PCMCIA_DMA_ADDR	   (0xE4000000)
   #define CFG_PCMCIA_DMA_SIZE	   ( 64 << 20 )
   #define CFG_PCMCIA_ATTRB_ADDR   (0xE8000000)
   #define CFG_PCMCIA_ATTRB_SIZE   ( 64 << 20 )
   #define CFG_PCMCIA_IO_ADDR	   (0xEC000000)
   #define CFG_PCMCIA_IO_SIZE	   ( 64 << 20 )

/*--------------------------------------------------------------------
 * IDE/ATA stuff (Supports IDE harddisk on PCMCIA Adapter)
 *-------------------------------------------------------------------
 */

   #define CONFIG_IDE_PCCARD 1	/* Use IDE with PC Card	Adapter	*/

   #undef CONFIG_IDE_PCMCIA 	/* Direct IDE    not supported	*/
   #undef CONFIG_IDE_LED	/* LED   for ide not supported	*/
   #undef CONFIG_IDE_RESET	/* reset for ide not supported	*/
   #define CFG_IDE_MAXBUS    1	/* max. 1 IDE bus		*/
   #define CFG_IDE_MAXDEVICE 1	/* max. 1 drive per IDE bus	*/
   #define CFG_ATA_IDE0_OFFSET	0x0000
   #define CFG_ATA_BASE_ADDR	CFG_PCMCIA_MEM_ADDR

/* Offset for data I/O			*/
   #define CFG_ATA_DATA_OFFSET	(CFG_PCMCIA_MEM_SIZE + 0x320)

/* Offset for normal register accesses	*/
   #define CFG_ATA_REG_OFFSET	(2 * CFG_PCMCIA_MEM_SIZE + 0x320)

/* Offset for alternate registers	*/
   #define CFG_ATA_ALT_OFFSET	0x0100



 Thank you very much for your help.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
