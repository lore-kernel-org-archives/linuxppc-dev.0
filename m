Message-ID: <3D6C4B8E.8070706@embeddededge.com>
Date: Wed, 28 Aug 2002 00:03:26 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: acurtis@onz.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 8260/8xx Embedded Boot patch
References: <200208271706.51677.acurtis@onz.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Allen Curtis wrote:

> Fix/cleanup to embedded boot

Please explain these changes.  You shouldn't be using embed_config.c if
you don't have EMBEDDEDBOOT defined.  The EMBEDDEDBOOT is a generic
bootloader that should only have unique functions in embed_config.c
You should be definining a board configuration for whatever you are
doing and use that.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
