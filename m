Date: Wed, 7 Jul 2004 08:24:16 +0200
From: Olaf Hering <olh@suse.de>
To: =?utf-8?B?UGF3ZcWC?= Sikora <pluto@pld-linux.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [kernel26@ppc] fixes...
Message-ID: <20040707062416.GA17456@suse.de>
References: <200407070042.56649.pluto@pld-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <200407070042.56649.pluto@pld-linux.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


 On Wed, Jul 07, Paweł Sikora wrote:

> Hi,
> Could You look at attached patches?
>
> [1] 2.6.7-ppc-asm-defs.patch
> assembler reports an error at `dssall'

I think -Wa,-many for CFLAGS and AFLAGS will fix that, this has been
discussed last week on this list.

> [3] 2.6.7-ppc-ipr-div.patch
> similar sector_div() bug.

you should send this to the driver maintainer,
Brian J King <bjking1@us.ibm.com>


--
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
