Message-ID: <3CFCF31B.50103@embeddededge.com>
Date: Tue, 04 Jun 2002 13:04:27 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Cc: David Gibson <david@gibson.dropbear.id.au>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: More details on the telnet with CONFIG_PIN_TLB problems
References: <20020603075322.GI6765@zax> <15612.47259.378190.93509@argo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Paul Mackerras wrote:

> Looks like Ben and I have found the problem;

Cool.  I know this works OK on 8xx, I just haven't finished a working
tlb miss handler that will work regardless of the page size.

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
