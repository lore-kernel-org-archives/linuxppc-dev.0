Date: Thu, 30 Dec 1999 10:39:45 -0800
From: David Hinds <dhinds@valinux.com>
To: Dan Malek <dan@netx4.com>
Cc: Magnus Damm <damm@kieraypc01.p.y.ki.era.ericsson.se>,
        dhinds@sourceforge.org,
        linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>,
        phr-pcmcia@nightsong.com, nknack@vikingcomponents.com
Subject: Re: CompactFlash Viking problem
Message-ID: <19991230103945.D30321@valinux.com>
References: <386B5437.86F7449B@switchboard.ericsson.se> <386B855F.58D64F2B@netx4.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <386B855F.58D64F2B@netx4.com>; from Dan Malek on Thu, Dec 30, 1999 at 11:16:31AM -0500
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Dec 30, 1999 at 11:16:31AM -0500, Dan Malek wrote:
> Magnus Damm wrote:
> 
> > Another thing is that if I stick to access the ATA registers
> > all CompactFlash cards (even the Viking) work.
> 
> I haven't been very successful using Flash cards (PCMCIA or
> Compact Flash) as pure memory devices.  I have always ended up
> using them as ATA disk drives.

I don't know of any cards that can actually be used either way (either
as a plain memory card, or as an ATA device).  As far as I know, they
are either one or the other.  All PCMCIA ATA devices are supposed to
support a memory mapped access mode, but that just puts the ATA
registers in memory space instead of IO space.

-- Dave

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
