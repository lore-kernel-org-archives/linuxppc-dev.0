Message-ID: <3A6CD3B6.6B541DEB@mvista.com>
Date: Mon, 22 Jan 2001 16:43:34 -0800
From: Frank Rowand <frank_rowand@mvista.com>
Reply-To: frowand@mvista.com
MIME-Version: 1.0
To: frowand@mvista.com
CC: Roman Zippel <zippel@fh-brandenburg.de>, Dan Malek <dan@mvista.com>,
        Jeff Hartmann <jhartmann@valinux.com>, michdaen@iiic.ethz.ch,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Gareth Hughes <gareth@valinux.com>, linuxppc-dev@lists.linuxppc.org,
        dri-devel@lists.sourceforge.net, Paul Mackerras <paulus@linuxcare.com>
Subject: Re: [Dri-devel] PPC Lockup (ati-pcigart-branch)
References: <Pine.GSO.4.10.10101222326300.26751-100000@zeus.fh-brandenburg.de> <3A6CD180.EDFEA254@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Frank Rowand wrote:
>


> hoping I can continue to get away with in the future.  I map all of physical
> SDRAM to the kernel virtual address space:
>
>   0xc000'0000 through (0xc000'0000 + size of memory - 1)
>
> via large TLB entries (each entry typically covering a range of 8MB).

oops, trivial mis-speak.  Each large entry typically covering a range of 16MB.

-Frank
--
Frank Rowand <frank_rowand@mvista.com>
MontaVista Software, Inc

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
