Content-Type: text/plain; charset=iso-8859-1
MIME-Version: 1.0
To: dan@embeddededge.com
Cc: acurtis@onz.com, linuxppc-embedded@lists.linuxppc.org
From: acurtis@onz.com
Subject: Re: 8260 Memory Management
Date: Fri, 23 Aug 2002 17:01:44 -0700 (PDT)
Message-Id: <20020823170144.12735.h003.c007.wm@mail.directvinternet.com.criticalpath.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> &gt; Basically, remove all the CONFIG_8260 conditional compile stuff.
>
> And what useful purpose do you expect this to do for us?

Basically:
a) remove unnecessary inconsistencies within the PPC implementations
b) perhaps help with PCI stuff. The SYM SCSI drivers are working fine for all the
other PPC users but anyone that I have talked to with an 8260 has one problem or
another.

------------------------------------------------------------
Allen Curtis              |  All good things come to those
Ones and Zeros, Inc.      |  who wait. Some of us have to
mailto:acurtis@onz.com    |  wait a little longer.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
