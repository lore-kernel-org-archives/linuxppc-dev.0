Message-ID: <FA06AA2C99BCD511951200005A99441001E3F16F@irvexch1.sextantifs.com>
From: "Curtis, Allen" <Allen.Curtis@Thales-IFS.com>
To: "'Roland Dreier'" <roland@topspin.com>,
	"Curtis, Allen" <Allen.Curtis@Thales-IFS.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Date: Fri, 9 May 2003 12:54:02 -0700
Subject: RE: pci_unmap_single() and CONFIG_NOT_COHERENT_CACHE
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
>    Allen> I noticed in pci.h that pci_unmap_single() is a null
>    Allen> function. (essentially does nothing) Shouldn't is call
>    Allen> consistent_sync() so that flush_dcache_range() is called?
>
>No, the cache invalidate or flush has to happen when pci_map_single()
>is used.  There's nothing to do after the DMA is done (which is when
>pci_unmap_single() gets called).
>

Thanks, shortly after pressing the send button I realized that this was a
dumb question.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
