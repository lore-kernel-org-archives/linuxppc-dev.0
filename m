Message-ID: <3D4FD042.5070405@embeddededge.com>
Date: Tue, 06 Aug 2002 09:33:54 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: acurtis@onz.com
Cc: Ppc Developers <linuxppc-dev@lists.linuxppc.org>
Subject: Re: asm-ppc/io.h - 8260 conditional compile?
References: <NCBBIINEHIPFGJPLBEIFGEGADKAA.acurtis@onz.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Allen Curtis wrote:

> It appears to me that the inline functions in this file are missing the
> CONFIG_8260 conditional compile. Can anyone confirm if this it true?

I can confirm it is not true.  What would need to change for 8260?  It
has worked for a long time.


	-- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
