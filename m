Content-Type: text/plain; charset=iso-8859-1
MIME-Version: 1.0
To: trini@kernel.crashing.org
Cc: acurtis@onz.com, dan@embeddededge.com,
	linuxppc-embedded@lists.linuxppc.org
From: acurtis@onz.com
Subject: Re: 8260/8xx Embedded Boot patch
Date: Tue, 27 Aug 2002 17:28:29 -0700 (PDT)
Message-Id: <20020827172829.3580.h002.c007.wm@mail.directvinternet.com.criticalpath.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> The first thing I saw was the define_bool CONFIG_ALL_PPC n.
> If this was actually needed someplace, there's a bug there that needs to
> be fixed.

This is not required. All of the xxxx8260_defconfig files define this so you do
not get all of the generic Mac stuff like IDE and video. If it is not appropriate
take it out. It just serves to weed out a lot of options you are just going to
turn-off anyway.

------------------------------------------------------------
Allen Curtis              |  All good things come to those
Ones and Zeros, Inc.      |  who wait. Some of us have to
mailto:acurtis@onz.com    |  wait a little longer.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
