Date: Tue, 2 Apr 2002 17:21:54 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Dan Malek <dan@embeddededge.com>
Cc: paulus@samba.org, linux-galileo@source.mvista.com,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: EV-64260-BP & GT64260 bi_recs
Message-ID: <20020403002154.GB744@opus.bloom.county>
References: <0203210213.AA15856@ivan.Harhan.ORG> <3C99801A.8070002@embeddededge.com> <15526.51621.991410.781713@argo.ozlabs.ibm.com> <3CA8A96D.9040309@embeddededge.com> <15529.17031.622986.926261@argo.ozlabs.ibm.com> <3CA9EA93.5000404@embeddededge.com> <20020402201235.GA28287@opus.bloom.county> <3CAA1C80.3070407@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3CAA1C80.3070407@embeddededge.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Apr 02, 2002 at 04:02:56PM -0500, Dan Malek wrote:
> Tom Rini wrote:
>
> >It was probably me.
>
> Heh.....I'm just having some fun :-).

Ya, I figured :)

> I also know the reason
> you probably changed it was to either make munuconfig or
> something work, or had plans for CML-2.  I think some of the
> confusing stuff we have for configuration is due to the tools
> themselves, and that sometimes is reflected in the way the
> code (#define and #ifdef) is written.

Yes, there are some neat things which might be less feasible, or at
least less of a good idea due to the current tools.

> >...  One thing I want to do in the 2.5 tree is make
> >arch/ppc/platforms/{8xx,4xx}.in and source those from
> >arch/ppc/config.in,
>
> I know that would help.  What happened to CML-2?

I have a feeling that ESR stopped announcing releases of it on l-k since
it wasn't adopted yet, and Linus has decided to fix more important
things than the config system (and ESR refuses to try and transition
from CML1 to CML2 in a manner that can be easily verified to be correct
or stop trying to tackle the Aunt Tillie problem at the same time).

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
