Return-Path: <cavok@tiscali.it>
Received: from filibusta.crema.unimi.it (filibusta.crema.unimi.it
	[159.149.70.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "filibusta.crema.unimi.it",
	Issuer "filibusta.crema.unimi.it" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 2B8E2679A6
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  7 Apr 2006 08:10:43 +1000 (EST)
Date: Fri, 7 Apr 2006 00:10:56 +0200
From: Domenico Andreoli <cavokz@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: freescale lite 5200 board and kernel 2.6
Message-ID: <20060406221056.GA15540@raptus.dandreoli.com>
References: <20060405210654.GA16848@raptus.dandreoli.com>
	<20060405212741.GC61331@server.idefix.loc>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="qMm9M+Fa2AknHoGS"
In-Reply-To: <20060405212741.GC61331@server.idefix.loc>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 05, 2006 at 11:27:41PM +0200, Matthias Fechner wrote:
> Hello Domenico,

hi Matthias,

> * Domenico Andreoli <cavokz@gmail.com> [05-04-06 23:06]:
> > is there any patchset i can use for kernel 2.6? is it production-ready?
> > why isn't already in vanilla 2.6? has any sense to stay with kernel 2.4?
> 
> I'm not sure if this helps, but I was successfully in getting a kernel
> 2.6 running with the icecube board. I have written a short docu in my
> wiki (booting with tftp and rootnfs over NFS):
> http://wiki.idefix.fechner.net/index.php/IceCube#Writing_kernel_modules_for_2.6

this is a very nice page, it is now my reference :)

anyway i cannot say i made it, my icecube is still not under control.

every time i boot the 2.6 kernel after the original 2.4 one, the nic
seems to work. on subsequent boots, even after board resets, it does not.
i still need to check what happens removing the power cord.

kernel is built following the instructions on your wiki, i attached
the config file. please have a look, let me know if any check/test may
be advised.

cheers
domenico

-----[ Domenico Andreoli, aka cavok
 --[ http://people.debian.org/~cavok/gpgkey.asc
   ---[ 3A0F 2F80 F79C 678A 8936  4FEE 0677 9033 A20E BC50

--qMm9M+Fa2AknHoGS
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="config-2.6.16.1-mpc52xx.gz"
Content-Transfer-Encoding: base64

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
SQVDH3zOJRlsANIoEQBccXYiaU8AAA==

--qMm9M+Fa2AknHoGS--
