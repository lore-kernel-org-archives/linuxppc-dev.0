Return-Path: <anton@samba.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6D0B81A198A
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jul 2015 20:10:03 +1000 (AEST)
Date: Wed, 8 Jul 2015 20:10:01 +1000
From: Anton Blanchard <anton@samba.org>
To: Scott Wood <scottwood@freescale.com>
Cc: Samuel Mendoza-Jonas <sam.mj@au1.ibm.com>, <linuxppc-dev@ozlabs.org>
Subject: Re: [kexec-lite PATCH V2] trampoline: Reset primary cpu endian to
 big-endian
Message-ID: <20150708201001.3245ba62@kryten>
In-Reply-To: <1436326636.2658.68.camel@freescale.com>
References: <1436326178-17021-1-git-send-email-sam.mj@au1.ibm.com>
 <1436326636.2658.68.camel@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Scott,

> Is kexec-lite meant to be specific to book3s-64? 

It was originally built to test book3s-64 kexec. Likely some other
issues need fixing for other ppc sub arches, but it is nice to
have a very simple kexec.

Anton
