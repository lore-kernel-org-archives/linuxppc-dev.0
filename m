Return-Path: <anton@ozlabs.org>
Date: Wed, 7 Mar 2007 23:32:31 -0600
From: Anton Blanchard <anton@samba.org>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: speed up kernel_thread
Message-ID: <20070308053231.GA20496@kryten>
References: <20070307212910.GA3648@kryten>
	<20070307220104.GA32067@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070307220104.GA32067@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 
Hi Scott,

> Shouldn't this be stwu on 32-bit?

Definitely, thanks for spotting it.

Anton
