Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17360.28562.420811.304052@cargo.ozlabs.ibm.com>
Date: Fri, 20 Jan 2006 16:05:22 +1100
From: Paul Mackerras <paulus@samba.org>
To: Vitaly Bordug <vbordug@ru.mvista.com>
Subject: Re: [PATCH] PPC32 CPM_UART: update to utilize the new TTY flip API
In-Reply-To: <20060115154409.1627.95041.stgit@vitb.dev.rtsoft.ru>
References: <20060115154409.1627.95041.stgit@vitb.dev.rtsoft.ru>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Vitaly Bordug writes:

> This replaces old direct usage of tty->flip stuff with relative flip API
> calls.

Could I have a Signed-off-by line from you for it please?

Paul.
