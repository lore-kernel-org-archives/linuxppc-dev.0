Message-ID: <3C5190CF.9000102@embeddededge.com>
Date: Fri, 25 Jan 2002 12:07:27 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: paulus@samba.org
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: OpenPIC_NumInitSenses
References: <15439.64102.68217.293733@argo.ozlabs.ibm.com>	<3C50C615.7090503@embeddededge.com> <15440.55617.344240.588918@argo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul Mackerras wrote:

> Well, you need some way to tell the openpic code how many ISRs there
> are.  You don't _need_ to use OpenPIC_NumInitSenses to do that. :)

It was a quick hack that did the trick :-).

> .... and they are not contiguous either (I just looked at the MPC107
> manual).  Who designed this thing?

Some embedded person, I guess :-).

> ... have a look - I think it should let you handle the MPC107 quite
> painlessly, but if not let me know what else is needed.

Cool.  Thanks.


	-- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
