Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0B3B0DEB62
	for <linuxppc-dev@ozlabs.org>; Sat, 31 May 2008 07:49:29 +1000 (EST)
In-Reply-To: <1212180199-968-2-git-send-email-galak@kernel.crashing.org>
References: <1212180199-968-1-git-send-email-galak@kernel.crashing.org>
	<1212180199-968-2-git-send-email-galak@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <165963514fdb3980898f3babaad546a9@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] 85xx: Add next-level-cache property
Date: Fri, 30 May 2008 23:49:19 +0200
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Added next-level-cache to the L1 and a reference to the new L2 label.

Where is this property defined?  I can't find it.

The PowerPC binding defines an "l2-cache" property for this (it
points from CPU node to L2 cache node, from L2 cache node to L3
cache node, from L3 cache node to L4 cache node, etc.)


Segher
