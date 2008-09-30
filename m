Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 59C18DE955
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  1 Oct 2008 03:36:42 +1000 (EST)
Message-ID: <48E262FF.9020108@freescale.com>
Date: Tue, 30 Sep 2008 12:33:51 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Remi Lefevre <rlefevre@gmail.com>
Subject: Re: FS_ENET ERROR(s) 0x12 at second NFS RPC port lookup (100005/1)
References: <4e0b9cb00809300944r2c2359dbx6df882705106c4d1@mail.gmail.com>
In-Reply-To: <4e0b9cb00809300944r2c2359dbx6df882705106c4d1@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Remi Lefevre wrote:
> [    5.573391] fs_enet: eth0 FS_ENET ERROR(s) 0x12

This is a transmit error; more detail can be found in the buffer descriptor.

Check your pin and clock configuration.

-Scott
