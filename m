Message-ID: <D53137D1F3DDD211A3750800060DA31301702394@viee122a.erd.siemens.at>
From: Eisenzopf Thomas <thomas.eisenzopf@siemens.at>
To: linuxppc-embedded@lists.linuxppc.org
Subject: 8xxROM with MPC860ADS - ATA Flash Card not recognized?
Date: Thu, 30 Mar 2000 10:11:39 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hallo,

does anyone know this problem:

Using 8xxROM on a MPC860ADS board does not recognize my ATA flash card in
the PCMCIA slot (SanDisk compact flash with PCMCIA adapter). In the
beginning of the bootloader startup I get the message "pcmcia: no card
present". Parts of my "config.h" (I tried with and without PCMCIABUG):

.
.
.
#define MPC860 1

#define CONFIG_ADS 1   /* define if your board is FADS */
.
.
.
/* disk configuration */

#define CONFIG_DISK_ATA 1
#undef CONFIG_DISK_ATA_PCMCIABUG
#undef CONFIG_DISK_ROM

#define CONFIG_DISK_SPINUP_TIME 1000000

#if 0
#define CONFIG_DISK_DEFAULTDEV "ata"
#define CONFIG_DISK_DEFAULTPART "1"
#endif

/* PCMCIA configuration */
#define PCMCIA_MAX_SLOTS    2

#ifdef MPC860
#  define PCMCIA_SLOT_A 1
#endif
#if defined(MCP823) || defined(MPC860)
#  define PCMCIA_SLOT_B 1     /* 823 does only have a B slot */
#endif
.
.
.

Any help is appreciated!

Best regards,
Thomas.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
