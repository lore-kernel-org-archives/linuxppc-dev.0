Date: Mon, 13 May 2002 12:09:00 -0400
From: Ben Collins <bcollins@debian.org>
To: Bill Fink <billfink@mindspring.com>
Cc: linux1394-devel@lists.sourceforge.net,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Firewire Disk Broken in 2.4.19-pre8-ben0 kernel (was working fine with 2.4.18-ben0)
Message-ID: <20020513160900.GK494@blimpo.internal.net>
References: <20020513105519.7cb1daf8.billfink@mindspring.com> <20020513151319.GI494@blimpo.internal.net> <20020513120748.654bcbc0.billfink@mindspring.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020513120748.654bcbc0.billfink@mindspring.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, May 13, 2002 at 12:07:48PM -0400, Bill Fink wrote:
> On Mon, 13 May 2002, Ben Collins wrote:
>
> > > ohci1394: $Revision: 1.101 $ Ben Collins <bcollins@debian.org>
> >
> > Try the SVN code base (check the website for how to download).
>
> Hi Ben,
>
> As I indicated in my earlier message, I already tried the latest
> ieee1394-473 tarball (dated May 13).  I gave the output from the
> ieee1394-444 tarball (dated April 4), since that was the earliest
> point I knew it to be broken.  For completeness, here is the dmesg
> output from the ieee1394-473 tarball:
>
> ohci1394: $Rev: 460 $ Ben Collins <bcollins@debian.org>
> ohci1394_0: OHCI-1394 1.0 (PCI): IRQ=[63]  MMIO=[80080000-80080800]  Max Packet=[2048]
> ieee1394: received packet during reset; ignoring
> ohci1394_0: Unexpected tcode 0xf(0x6001c1ff) in AR ctx=0, length=-1: dma prg stopped
> ieee1394: ConfigROM quadlet transaction error for node 00:1023
> ieee1394: Host added: Node[01:1023]  GUID[00000000feeb324a]  [Linux OHCI-1394]
>
> I know it is reporting "$Rev: 460" but it is in fact from the ieee1394-473
> tarball.

460 was the last revision that ohci1394.c changed, so that's normal.
BenH may know more about the problem here.

--
Debian     - http://www.debian.org/
Linux 1394 - http://linux1394.sourceforge.net/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
