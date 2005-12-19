Return-Path: <panto@intracom.gr>
Received: from mailserv.intranet.gr (mailserv.intranet.GR [146.124.14.106])
	by ozlabs.org (Postfix) with ESMTP id 46E9068902
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 Dec 2005 00:13:30 +1100 (EST)
Received: from mailserv.intranet.gr (localhost [127.0.0.1])
	by mailserv.intranet.gr (8.13.1/8.13.1) with ESMTP id jBJDMJgV006341
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 19 Dec 2005 15:22:19 +0200 (EET)
Message-ID: <43A6B0B1.5070909@intracom.gr>
Date: Mon, 19 Dec 2005 15:08:01 +0200
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: Nathael Pajani <nathael.pajani@cpe.fr>
References: <20051219140927.55259cea.nathael.pajani@cpe.fr>
In-Reply-To: <20051219140927.55259cea.nathael.pajani@cpe.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] CPM initial console on ttyS instead of ttyCPM
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Nathael Pajani wrote:
> Hi!
> 
> here is a patch to have the CPM consoles on /dev/ttyS* instead of /dev/ttyCPM*
> Of course, it depends on not already having a 8250 like uart configured, in which case it falls back to ttyCPM.
> 
> Signed-off-by: Nathael Pajani <nathael.pajani at cpe.fr>
>

[snip]

> 
> 
> 

WTF is that? There was a reason why both the device number & name changed.
And misusing the 8250 config option, that's nice.

Try to come up with something less intrusive please.

Pantelis
