Message-ID: <3BEADFEF.4000307@embeddededge.com>
Date: Thu, 08 Nov 2001 14:41:35 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Ricardo Scop <scop@vanet.com.br>
Cc: linuxppc-embedded@lists.linuxppc.org, lehder@lists.linuxppc.org,
	mercio@lists.linuxppc.org
Subject: Re: Linuxppc and MPC8255 routing performance
References: <9729.011107@vanet.com.br>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Ricardo Scop wrote:


> Does that sound ok, compared to other 8260 systems?

No, not even close.  Something must be wrong with your memory
interface or system.  The data cache enabled should be significantly
faster, and on an 8260 you can run all three fast ethernets at full
speed.  Using FTP as a benchmark isn't usually the best choice.  You
should be running carefully controlled network benchmark applications.

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
