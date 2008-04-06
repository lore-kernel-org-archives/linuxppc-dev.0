Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 99338DDDE9
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Apr 2008 01:33:42 +1000 (EST)
In-Reply-To: <1207487181.6809.18.camel@vader.jdub.homelinux.org>
References: <1207487181.6809.18.camel@vader.jdub.homelinux.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <1d71203db510d706edf4acf1a6aa52bd@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: 4xx defconfig reorg
Date: Sun, 6 Apr 2008 17:32:42 +0200
To: jwboyer@linux.vnet.ibm.com
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Unless someone screams loudly and has reasons why this shouldn't go in,

These configs won't show up for "make help" anymore, which of course is
nice because that list was too long, but we need a way to get that back
since it was useful.  I'll see what I can do.


Segher
