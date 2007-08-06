Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <20070806040249.GA6103@localhost.localdomain>
References: <9696D7A991D0824DBA8DFAC74A9C5FA303156076@az33exm25.fsl.freescale.net>
	<20070806040249.GA6103@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <acbb5c6cec93d20a19f48e86bc5e7a73@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 3/3] First cut at PReP support for arch/powerpc
Date: Mon, 6 Aug 2007 21:45:01 +0200
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Yoder Stuart-B08248 <stuart.yoder@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> However, the interrupt mapping spec says that all interrupt
>> controller (regardless of device_type) must have a
>> property named "interrupt-controller" to identify
>> the device node as an interrupt controller and root of
>> a interrupt tree.
>> See: http://playground.sun.com/1275/practice/imap/imap0_9d.html
>
> Ah, yes.  Added to both the mpic and 8259.

See?  Even if I make mistakes some good comes from it!

;-) ;-) ;-)


Segher
