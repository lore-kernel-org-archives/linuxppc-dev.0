Message-ID: <3BEC0578.9020704@embeddededge.com>
Date: Fri, 09 Nov 2001 11:34:00 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Ricardo Scop <scop@digitel.com.br>
Cc: linuxppc-embedded@lists.linuxppc.org, mercio@digitel.com.br,
	lehder@digitel.com.br
Subject: Re: Linuxppc and MPC8255 routing performance
References: <9729.011107@vanet.com.br> <01110818021400.00999@scop.digitel.com.br> <3BEAFCEB.3090604@embeddededge.com> <01110912552900.03277@scop.digitel.com.br>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Ricardo Scop wrote:


> By "backside" memory you mean ... the internal data cache, perhaps?

No, bad use of words on my part.  The 8260 has a local bus that can only
be accessed from the CPU core and CPM (it's not on the 60x bus).  Maybe
the 8255 doesn't have this feature, I don't remember.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
