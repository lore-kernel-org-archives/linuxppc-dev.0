Message-ID: <3C50C615.7090503@embeddededge.com>
Date: Thu, 24 Jan 2002 21:42:29 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: paulus@samba.org
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: OpenPIC_NumInitSenses
References: <15439.64102.68217.293733@argo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul Mackerras wrote:

> Who was it that wanted this horrible hack in open_pic.c?

RTFA (archives :-).  We have discussed this enough in the past.

Just like the comment states, we need it because of the way the
107/EPIC maps on the "standard" OpenPIC structure.  The simple
answer is the interrupts are offset by 16 on the EPIC, so the
interrupt numbers don't match the offset value.  The EPIC may
say there are only 24 vectors, but for the code to work we need
to tell the OpenPIC code there are up to 16 more than that.


> I am about to add an openpic_set_sources function which will let us
> handle the distributed openpic in IBM pSeries machines more cleanly
> and also allow us to remove this hack.

There have been posts about better OpenPIC updates, but I guess they
have been ignored?

> Thus if you want to say how many interrupt sources there are, ....

I can't discuss much right now because I'm travelling with basically only
e-mail access.  I'll look at some code, but I guess you should just
make the changes and we'll try again to make EPIC fit :-).

Thanks.


	-- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
