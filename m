Message-ID: <3CAA1C80.3070407@embeddededge.com>
Date: Tue, 02 Apr 2002 16:02:56 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
Cc: paulus@samba.org, linux-galileo@source.mvista.com,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: EV-64260-BP & GT64260 bi_recs
References: <0203210213.AA15856@ivan.Harhan.ORG> <3C99801A.8070002@embeddededge.com> <15526.51621.991410.781713@argo.ozlabs.ibm.com> <3CA8A96D.9040309@embeddededge.com> <15529.17031.622986.926261@argo.ozlabs.ibm.com> <3CA9EA93.5000404@embeddededge.com> <20020402201235.GA28287@opus.bloom.county>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tom Rini wrote:

> It was probably me.

Heh.....I'm just having some fun :-).  I also know the reason
you probably changed it was to either make munuconfig or
something work, or had plans for CML-2.  I think some of the
confusing stuff we have for configuration is due to the tools
themselves, and that sometimes is reflected in the way the
code (#define and #ifdef) is written.


> ...  One thing I want to do in the 2.5 tree is make
> arch/ppc/platforms/{8xx,4xx}.in and source those from
> arch/ppc/config.in,

I know that would help.  What happened to CML-2?

Thanks.


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
