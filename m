Message-ID: <3CDA9296.1020907@embeddededge.com>
Date: Thu, 09 May 2002 11:15:34 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Steven Blakeslee <BlakesleeS@embeddedplanet.com>
Cc: "'linuxppc-dev@lists.linuxppc.org'" <linuxppc-dev@lists.linuxppc.org>,
	"'nanogui@linuxhacker.org'" <nanogui@linuxhacker.org>
Subject: Re: IRQ's
References: <D73A25AA6E54D511AD74009027B1110F2C829F@ORION>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Steven Blakeslee wrote:

 > ... Is there anything else
> involved in assigning and using an IRQ?  I would appreciate any advice
> anyone could give.

You need to configure the processor pin multiplex in the SIU depending
upon the hardware design.


	-- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
