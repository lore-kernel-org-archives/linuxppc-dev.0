MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <16544.1344.359606.598912@cargo.ozlabs.ibm.com>
Date: Tue, 11 May 2004 08:42:08 +1000
From: Paul Mackerras <paulus@samba.org>
To: Olaf Hering <olh@suse.de>
Cc: akpm@osdl.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] export clear_pages on ppc32
In-Reply-To: <20040510153624.GA9214@suse.de>
References: <20040510153624.GA9214@suse.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Olaf Hering writes:

> ext3 as module is not possible in 2.6.6, clear_pages, called from
> clear_page, is not exported.

clear_page is an inline function now, we should remove its export.

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
