Return-Path: <hachti@hachti.de>
Received: from ente.hachti.de (ente.hachti.de [212.227.83.80])
	by ozlabs.org (Postfix) with ESMTP id 1DB21DDFA5
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Aug 2008 13:34:59 +1000 (EST)
Message-ID: <48A3A7E0.8020903@hachti.de>
Date: Thu, 14 Aug 2008 05:34:56 +0200
From: Philipp Hachtmann <hachti@hachti.de>
MIME-Version: 1.0
To: Stu Bershtein <sbershtein@Quantum3D.com>
Subject: Re: How to use ramdisk on the ml300?
References: <931ae8260808132008i1cac2e91kc76c099ecc574cd0@mail.gmail.com>
	<8BB04FAC749BD24BBA250E9D09F2F18B20CCAF@MAIL-SJC.quantum3d.com>
In-Reply-To: <8BB04FAC749BD24BBA250E9D09F2F18B20CCAF@MAIL-SJC.quantum3d.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: yanlong wang <killyouatonce@gmail.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

> As I discovered today, it is not necessary to use u-boot on the ml507
> board.  I cannot speak with certainty about the ml300.  For the ml507
> the ramdisk image gets saved as a separate section in the elf file
> that is downloaded with the zImage.  In the ml507 case the image is a
> gzipped ext2 filesystem.  Makes a very tidy package I'm sure you will
> agree!
But with U-boot it can be way more comfortable!

Regards,
Ph :)

-- 
http://www.hachti.de
