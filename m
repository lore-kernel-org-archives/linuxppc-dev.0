Return-Path: <cfriesen@nortel.com>
Received: from zctfs063.nortelnetworks.com (zctfs063.nortelnetworks.com
	[47.164.128.120]) by ozlabs.org (Postfix) with ESMTP id 4F235683E7
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Oct 2005 15:07:35 +1000 (EST)
Message-ID: <4340BC80.4000500@nortel.com>
Date: Sun, 02 Oct 2005 23:07:12 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
MIME-Version: 1.0
To: Bob Brose <linuxppcdev@qbjnet.com>
References: <20051003021129.20564.qmail@kunk.qbjnet.com>
In-Reply-To: <20051003021129.20564.qmail@kunk.qbjnet.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
Subject: Re: Q: signed vs unsigned char,
	PPC vs x86 gcc 3.3.5 compiler differences
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Bob Brose wrote:

> Does this mean the char in x86 is signed and in PPC it's unsigned?
> Has it always been thus?

 From K+R:

"Whether plain chars are signed or unsigned is machine-dependent, but 
printable characters are always positive."

Chris
