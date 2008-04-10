Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id 0CB96DE118
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 21:29:34 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: ppc405ep emac driver loading problem
Date: Thu, 10 Apr 2008 13:29:26 +0200
References: <6a6049b80804100337m6ab33fd5wd3cf9524e7f6d721@mail.gmail.com>
In-Reply-To: <6a6049b80804100337m6ab33fd5wd3cf9524e7f6d721@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200804101329.26846.sr@denx.de>
Cc: M B <super.firetwister@googlemail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 10 April 2008, M B wrote:
> I'm porting vanilla 2.6.25-rc8 (arch=powerpc) to a new board. UART is
> already working in the kernel and Uboot with UART and ethernet is also
> working.
> But I can't get the emac driver (ibm_newemac) working under Linux.
> On boot emac_init get's called and exits normally, but no probe or
> open will get called and no network devices (except lo) are known to
> the kernel.
>
> Do I have to do something more, than adding the mals and emacs to the
> device tree? I haven't seen any 40x or 44x board in the platforms
> folder doing something special for the emac.
>
> Any hints?

How does your .config look? Please send the EMAC defines only. And send the 
emac/mal related dts nodes. And the current kernel boot log.

Best regards,
Stefan

=====================================================================
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
=====================================================================
