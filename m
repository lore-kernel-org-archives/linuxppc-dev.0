Return-Path: <glikely@secretlab.ca>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.29])
	by ozlabs.org (Postfix) with ESMTP id 8F1E4DE0EA
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Apr 2009 05:10:20 +1000 (EST)
Received: by yx-out-2324.google.com with SMTP id 31so140453yxl.39
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Apr 2009 12:10:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1239995087.7210.19.camel@pasglop>
References: <20090414203313.8D8F11BE8056@mail209-sin.bigfish.com>
	<20090417154628.43F859D0055@mail178-wa4.bigfish.com>
	<625fc13d0904171022u4d7d5d8cve0ccfb74cc31f554@mail.gmail.com>
	<200904171307.47734.hollisb@us.ibm.com>
	<1239995087.7210.19.camel@pasglop>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 17 Apr 2009 13:10:03 -0600
Message-ID: <fa686aa40904171210y56835f98jfa4f3e08d97930aa@mail.gmail.com>
Subject: Re: Question about DBCR0 initialization for 440
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, John Linn <John.Linn@xilinx.com>,
	Hollis Blanchard <hollisb@us.ibm.com>,
	Tirumala Reddy Marri <tmarri@amcc.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 17, 2009 at 1:04 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Fri, 2009-04-17 at 13:07 -0500, Hollis Blanchard wrote:
>> On Friday 17 April 2009 12:22:37 Josh Boyer wrote:
>> > On Fri, Apr 17, 2009 at 11:46 AM, John Linn <John.Linn@xilinx.com> wro=
te:
>> > > Josh, any thoughts on putting this into head_44x.S?
>> >
>> > The code in the fsl file looks like the right solution. =A0I do have a=
n
>> > odd question though, in that it's hard for the
>> > kernel to really know if something like a BDI is running. =A0Namely,
>> > that config option doesn't cover RiscWatch in an obvious manner.
>>
>> Yeah, setting DBCR0 would interfere with all JTAG probes. The ifdef mean=
ds you
>> can't support both a JTAG debugger and hardware breakpoints in the same
>> binary? Now that's an annoying restriction.
>
> Might be worth checking if external debug is enabled, and override it
> only if it's not.

ppc440x5_um.pdf says that both can be enabled.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
