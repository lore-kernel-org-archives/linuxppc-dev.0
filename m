Message-ID: <F9102D41F595D311ACA7009027DE2C840527B4D2@c3po.heurikon.com>
From: "Johnson, Stephen" <stevebj@artesyncp.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: kmalloc vs pci_alloc_consistent
Date: Fri, 18 Jul 2003 08:34:24 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I don't know the history behind pci_alloc and wanted to throw this out there
to get some clarification.

What's the benefit of pci_alloc over using kmalloc with flags for a
cache-safe buffer?


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
