Message-ID: <3C8637A2.7020401@capflow.com>
Date: Wed, 06 Mar 2002 16:37:06 +0100
From: Laurent Pinchart <laurent.pinchart@capflow.com>
MIME-Version: 1.0
To: dan@embeddededge.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: linux-2.4.18 & copy-back cache mode
References: <3C85DE01.6000006@capflow.com> <3C862D12.2080304@embeddededge.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Reply-To: laurent.pinchart@capflow.com
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
>
>> After some more investigation I found that disabling Copy-Back mode
>> (thus enabling Write-Through mode) fixed the problem.
>
> What version of silicon?  Sounds like the "CPU6 errata" that affects
> anything less than a Rev. C part.

It's a Rev. D.3

Laurent Pinchart


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
