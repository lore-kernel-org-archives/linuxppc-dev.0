Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <17145.13414.996858.522127@cargo.ozlabs.ibm.com>
References: <17136.13558.773102.465379@cargo.ozlabs.ibm.com>
	<42F79D89.3040709@austin.ibm.com>
	<bb9b1e9e1ebdc3ac5b23b3cab327bfd5@kernel.crashing.org>
	<Pine.LNX.4.62.0508091510400.28068@numbat.sonytel.be>
	<dc3d7701e701266ffe852acf4da127ed@kernel.crashing.org>
	<17145.13414.996858.522127@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v622)
Message-Id: <c852c80b15c4a22ed26f5cbd9313b69d@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Date: Wed, 10 Aug 2005 12:15:09 +0200
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Cc: linuxppc64-dev@ozlabs.org, Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>
Subject: Re: Merging ppc32 and ppc64
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> It is already the case (and has always been the case) that you can't
> boot a vmlinux image directly from OF - there is always either or both
> of yaboot or a zImage wrapper in between anyway.

If you fix the ELF headers, you can boot a vmlinux directly
from OF just fine.

I agree getting rid of all that RELOC() stuff is a worthy goal;
I just hope there's a better way to do it...

Anyway, I'm not going to stand in you guys way -- please
just don't make it harder for me without reason, though.


Segher
