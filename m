Message-ID: <FA06AA2C99BCD511951200005A99441001E3F16E@irvexch1.sextantifs.com>
From: "Curtis, Allen" <Allen.Curtis@Thales-IFS.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Date: Fri, 9 May 2003 11:07:44 -0700
Subject: pci_unmap_single() and CONFIG_NOT_COHERENT_CACHE
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I noticed in pci.h that pci_unmap_single() is a null function. (essentially
does nothing) Shouldn't is call consistent_sync() so that
flush_dcache_range() is called?


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
