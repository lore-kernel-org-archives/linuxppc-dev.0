From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Giuliano Pochini <pochini@shiny.it>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: slow ZIP
Date: Wed, 2 May 2001 13:32:17 +0200
Message-Id: <20010502113217.25530@mailhost.mipsys.com>
In-Reply-To: <XFMail.010502102553.pochini@shiny.it>
References: <XFMail.010502102553.pochini@shiny.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Ok, but how can I enable DMA after boot ?  hdparm refuses to do it.

Look for the code in ide-pmac.c that skips enabling DMA when the
device is an ide floppy.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
