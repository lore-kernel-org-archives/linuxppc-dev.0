Message-ID: <3C046800.5030309@embeddededge.com>
Date: Tue, 27 Nov 2001 23:28:48 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Rudolf Ladyzhenskii <rudolf.ladyzhenskii@act-aus.net>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: BDI2000 PTEs
References: <B164B53F5BD6D511888D009027732E1A02498D@ntserver.act.domain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Rudolf Ladyzhenskii wrote:

> ..... At the moment I have memory translation enabled in BDI2000.
> PTBASE is set to 0xf0 and this entry is cleared.

That's not correct.

> .... This works for kernel
> debugging, but memory translation fails when I try to do dynamically loaded
> module debugging.

That's because without a page table the BDI2000 defaults to 1:1 translation.
By clearing the location above you told the BDI2000 that no page tables
are available.

> I guess I have to set PTE pointers for BDI2000.

No, you don't.  Just use a newer kernel that has this feature available for
all processors.  You could also copy the couple of lines of code from a
newer kernel into your 2.4.4 if you insist.

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
