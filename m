Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: [PATCH 2/2] port ndfc driver to of platform
Date: Thu, 14 Aug 2008 12:08:56 +0200
References: <20080801233000.3574434f@lappy.seanm.ca>
	<20080804132459.3fc12f59@lappy.seanm.ca>
	<20080813174536.677187f5@lappy.seanm.ca>
In-Reply-To: <20080813174536.677187f5@lappy.seanm.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200808141208.57345.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 13 August 2008, Sean MacLennan wrote:
> Changes to the warp platform with the ndfc as an of platform device.
> The main changes are:
> 
> * moving the NAND information to the DTS
> * removing warp-nand.c
> * moving the NAND fixups to cuboot-warp.c

The device tree stuff looks good, but the significant fixups you still
need to for the old hw do look like an indication that we should really
have a different way of producing almost-identical dts files.
The cleanest solution for now would be to have two dts files for warp,
but I can understand that you don't want to do that.

Did we ever come to a conclusion on how this could be done, e.g. with
preprocessed dts files or simpler dynamic patching of binary device
trees?

	Arnd <><
