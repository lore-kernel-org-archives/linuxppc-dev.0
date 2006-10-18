Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 7A0E767C4B
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Oct 2006 02:55:42 +1000 (EST)
Date: Wed, 18 Oct 2006 11:54:52 -0500
From: Olof Johansson <olof@lixom.net>
To: Jake Moilanen <moilanen@austin.ibm.com>
Subject: Re: [PATCH] 970GX cputable entry
Message-ID: <20061018115452.669f279a@pb15>
In-Reply-To: <1161186443.28147.46.camel@goblue>
References: <1161186443.28147.46.camel@goblue>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 18 Oct 2006 10:47:22 -0500 Jake Moilanen <moilanen@austin.ibm.com> wrote:

> 970GX cputable entry from Steve Winiecki.

Does 970GX have deep nap? If so, you should use __setup_cpu_ppc970MP
instead.

Also, you need to add the PVR to head_64.S and call preinit as
expected. Maybe not as critical since I'm not sure it'll probably never
be in a machine with Apple firmware, but still good to do for
consistency.


-Olof
