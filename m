Message-ID: <3C0EBEBC.2020600@embeddededge.com>
Date: Wed, 05 Dec 2001 19:41:32 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Rudolf Ladyzhenskii <rudolf.ladyzhenskii@act-aus.net>
Cc: "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: ATM switching in MPC8260
References: <B164B53F5BD6D511888D009027732E1A0249AF@ntserver.act.domain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Rudolf Ladyzhenskii wrote:



> For AAL0 this is from 8260 manual: "Automatic data forwarding....

I understand now.  If it can also do this for AAL2, there may be a
restriction on switching/forwarding layers that don't require a SAR.
However..........if your AAL5 PDU will fit into a single CPM buffer
it may do it :-).  Just ensure you don't have a LLC/SNAP or other
header in the PDU that may need some adjustment.  The SAR won't know
how to do that.

Have fun!


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
