Message-ID: <3E70C88B.70004@embeddededge.com>
Date: Thu, 13 Mar 2003 13:06:03 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Joakim Tjernlund <Joakim.Tjernlund@lumentis.se>
Cc: Stephan Linke <Stephan.Linke@epygi.de>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: question on howto use invalidate_dcache_range
References: <FCEAKDJJAPHPLJFINDAJCELACOAA.Stephan.Linke@epygi.de> <3E70B17E.9090507@embeddededge.com> <004501c2e989$a10a66c0$020120b0@jockeXP>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Joakim Tjernlund wrote:

> Yes, but you still need to invalidate the buffer before also or invalidate it when the buffer is freed which
> may be possible if you are using your own buffer mgmt.

Why?


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
