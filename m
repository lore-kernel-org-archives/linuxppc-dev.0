Message-ID: <3BEAFCEB.3090604@embeddededge.com>
Date: Thu, 08 Nov 2001 16:45:15 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Ricardo Scop <scop@digitel.com.br>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linuxppc and MPC8255 routing performance
References: <9729.011107@vanet.com.br> <3BEADFEF.4000307@embeddededge.com> <01110818021400.00999@scop.digitel.com.br>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Ricardo Scop wrote:


> Even without secondary (L2) cache?

Yes.  Depending upon the application, using the "backside" memory
for exclusive CPM use could be helpful.

> Err.. any suggestions, on those?

netperf comes to mind.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
