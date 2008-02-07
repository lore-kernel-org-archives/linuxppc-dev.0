Return-Path: <nikhilgautam1@gmail.com>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.187])
	by ozlabs.org (Postfix) with ESMTP id 19724DDE01
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  7 Feb 2008 11:36:18 +1100 (EST)
Received: by rv-out-0910.google.com with SMTP id c27so2201361rvf.9
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 06 Feb 2008 16:36:17 -0800 (PST)
Message-ID: <e9eeaac20802061636t14229054yebb41fa38dc5bffe@mail.gmail.com>
Date: Wed, 6 Feb 2008 16:36:17 -0800
From: "Nikhil Gautam" <nikhilgautam1@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: 440EPX is not booting from 1Gb/128MB NAND flash
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I am trying to boot my board which is based on Sequoia 440EPX. The
only difference between my board and the reference board is that I
have a 1 Gb NAND flash ( NAND01GW3B2A) instead of 256Mb flash present
on reference board.

In U-boot I have changed the board configuration file to reflect correct specs.

 * Now the NAND chip has to be defined (no autodetection used!)
 */
#define CFG_NAND_PAGE_SIZE	(2048)		/* NAND chip page size		*/
#define CFG_NAND_BLOCK_SIZE	(128 << 10)	/* NAND chip block size		*/
#define CFG_NAND_PAGE_COUNT	(64)		/* NAND chip page count		*/
#define CFG_NAND_BAD_BLOCK_POS	(5)		/* Location of bad block marker	*/
#define CFG_NAND_4_ADDR_CYCLE			/* Fourth addr used (>32MB)	*/

I have also changed the eeprom configuration word to
0x87788252
0x0947D010
0xA0A82358
0x0D050000

Is there any other place where some NAND configuration is defined?

Thanks
Nikhil
