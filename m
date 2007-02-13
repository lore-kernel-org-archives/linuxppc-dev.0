Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 36A9BDDD0D
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 13 Feb 2007 22:39:29 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Porting JFFS2 to 2.4.6 kernel
Date: Tue, 13 Feb 2007 12:39:12 +0100
References: <OFB2115A72.B614B566-ON65257281.001F4CE3-65257281.001F5609@lntemsys.com>
In-Reply-To: <OFB2115A72.B614B566-ON65257281.001F4CE3-65257281.001F5609@lntemsys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200702131239.12984.arnd@arndb.de>
Cc: Sendhilraj T <Sendhilraj.T@lntemsys.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tuesday 13 February 2007 06:43, Sendhilraj T wrote:
> I am trying to downport JFFS2 from 2.4.16 to 2.4.6 kernel. After including 
> the patch for JFFS2 and enabling the JFFS2 configuration in the .config 
> file if I restart ,the kernel is not getting booted.However if i disable 
> the JFFS2 configuraton in the patched kernel, it successfully boots....
> May I know the reason?
> Also I would like to know is there any working patch for JFFS2 available 
> for 2.4.6 kernel?
> Could anyone help us in this regard?

Sorry to tell you, but if you try to make a known broken kernel work,
you're pretty much on your own.

The current kernel version is 2.6.20, try to use that instead, as jffs2
works well in it.

	Arnd <><
