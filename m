Message-ID: <3C862D12.2080304@embeddededge.com>
Date: Wed, 06 Mar 2002 09:52:02 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: laurent.pinchart@capflow.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: linux-2.4.18 & copy-back cache mode
References: <3C85DE01.6000006@capflow.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Laurent Pinchart wrote:


> After some more investigation I found that disabling Copy-Back mode
> (thus enabling Write-Through mode) fixed the problem.

What version of silicon?  Sounds like the "CPU6 errata" that affects
anything less than a Rev. C part.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
