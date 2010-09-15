Return-Path: <sr@denx.de>
From: Stefan Roese <sr@denx.de>
To: devicetree-discuss@lists.ozlabs.org
Subject: Re: Question on of_address_to_resource() with offset != 0
Date: Wed, 15 Sep 2010 14:59:42 +0200
References: <201009141629.06825.stefan.roese@gmail.com>
In-Reply-To: <201009141629.06825.stefan.roese@gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201009151459.43087.sr@denx.de>
Cc: linuxppc-dev@lists.ozlabs.org, Detlev Zundel <dzu@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tuesday 14 September 2010 16:29:06 Stefan Roese wrote:
> I'm stumbling upon a problem noticed on the Ebony (440GP) eval board.
> Here the first chip-select is connected to 512KiB of SRAM and 512KiB
> NOR flash.

"Brown paper bag" time for me. Problem was located in U-Boot. Sorry for the 
noise.

Cheers,
Stefan

--
DENX Software Engineering GmbH,      MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich,  Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-0 Fax: (+49)-8142-66989-80 Email: office@denx.de
