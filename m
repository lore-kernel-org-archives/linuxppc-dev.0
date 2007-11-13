Return-Path: <glikely@secretlab.ca>
Received: from el-out-1112.google.com (el-out-1112.google.com [209.85.162.179])
	by ozlabs.org (Postfix) with ESMTP id 686EBDDE33
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Nov 2007 08:57:22 +1100 (EST)
Received: by el-out-1112.google.com with SMTP id r27so617511ele
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Nov 2007 13:57:21 -0800 (PST)
Message-ID: <fa686aa40711131357r6b072f4cgcd43c5cb8e73abdb@mail.gmail.com>
Date: Tue, 13 Nov 2007 14:57:21 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Gerhard Pircher" <gerhard_pircher@gmx.net>
Subject: Re: Hardware debuggers for PPC74xx G4 CPUs
In-Reply-To: <20071113214845.85820@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071113214845.85820@gmx.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 11/13/07, Gerhard Pircher <gerhard_pircher@gmx.net> wrote:
> I'm trying to debug a kernel lockup that occurs on my machine with all kernel
> versions >2.6.16. I don't have a clue what the root cause of this lockup is,
> thus I'm thinking about using a hardware debugger. Can anybody recommend a
> reasonably cheap hardware debugger that works with G4 CPUs and can interact
> with GDB/DDD?

Abatron BDI-2000.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
