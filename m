Reply-To: <acurtis@onz.com>
From: "Allen Curtis" <acurtis@onz.com>
To: "Dan Malek" <dan@embeddededge.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: 8260/8xx Embedded Boot patch
Date: Tue, 27 Aug 2002 21:16:18 -0700
Message-ID: <NCBBIINEHIPFGJPLBEIFAEEKDLAA.acurtis@onz.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <3D6C4B8E.8070706@embeddededge.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Please explain these changes.  You shouldn't be using embed_config.c if
> you don't have EMBEDDEDBOOT defined.  The EMBEDDEDBOOT is a generic
> bootloader that should only have unique functions in embed_config.c
> You should be definining a board configuration for whatever you are
> doing and use that.

I am using a modified EST8260 configuration. However the EST8260 embedded
stuff was broke. The bd_info structure was not passed up from head.S. The
call to configure the clocks was missing at the end of embed_config(). You
will also see that I translate the CONFIG_RPX (and other platform
conditionals) into CONFIG_EMBEDDED and use the single conditional compile.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
