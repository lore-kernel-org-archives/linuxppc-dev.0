Reply-To: <zjzhou@newrocktech.com>
From: "John Zhou" <zjzhou@newrocktech.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Cc: <wd@denx.de>
Subject: This question may be simple for you, but it doesn't let me sleeping.
Date: Wed, 13 Feb 2002 14:32:44 +0800
Message-ID: <000301c1b458$3f342bf0$9f02a8c0@newrock2>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <20030807213228.A9194C59E4@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear all,

This question may be simple for you, but it doesn't let me sleeping.

I have linux2.4.1 from Lineo runing on ppc8250, IMMR = 0xF0000000, in my driver function, I can directly access 0xF00xxxxx( internal memory area on PPC's chip), why? I think , in device driver, we also use logical memory, when accessing physical address, it should first map this address to be accessed by hardware. Is it right?

Another, I write a character driver to operate I2C device. When passing a logical address pointer to BD's address pointer that allocated by function kmalloc().  I can't correctly operate I2C device, But when I used free memory located in IMM ( 0xF00037C0 ~ 0xF00037F0  ) and directly pass this address to BD's buffer pointer, I can correctly operate I2C device. I also try to use function __pa() and virt_to_phys()  to map logical address to physical address, The driver still can't work OK.

Any comments and suggestions are appreciated!

John Zhou

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
