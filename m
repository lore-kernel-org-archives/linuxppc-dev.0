Return-Path: <dbaryshkov@gmail.com>
Received: from mail-vx0-f179.google.com (mail-vx0-f179.google.com
	[209.85.220.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1CBBEB6F74
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 23 Jul 2011 08:34:55 +1000 (EST)
Received: by vxi32 with SMTP id 32so2089229vxi.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 22 Jul 2011 15:34:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1311372381.25044.578.camel@pasglop>
References: <1308315107-29182-1-git-send-email-dbaryshkov@gmail.com>
	<1308315107-29182-3-git-send-email-dbaryshkov@gmail.com>
	<1309318559.32158.521.camel@pasglop>
	<CALT56yNrCwvBuu+rLgryf4XwA22Qz5-ntQ=rBv056ayT8F-oVw@mail.gmail.com>
	<1311372381.25044.578.camel@pasglop>
Date: Sat, 23 Jul 2011 02:34:52 +0400
Message-ID: <CALT56yMcW5pT9sMz0_83JTFTr5ehvB4pa8TBdgThAQPLighEoA@mail.gmail.com>
Subject: Re: [PATCH V3 2/2] cpc925_edac: support single-processor
	configurations
From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Harry Ciao <qingtao.cao@windriver.com>, Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@lists.ozlabs.org, Doug Thompson <dougthompson@xmission.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 7/23/11, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> On Sat, 2011-07-23 at 01:56 +0400, Dmitry Eremin-Solenikov wrote:
>> On 6/29/11, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>> > On Fri, 2011-06-17 at 16:51 +0400, Dmitry Eremin-Solenikov wrote:
>> >> If second CPU is not enabled, CPC925 EDAC driver will spill out
>> >> warnings
>> >> about errors on second Processor Interface. Support masking that out,
>> >> by detecting at runtime which CPUs are present in device tree.
>> >
>> > Doug ? Are you going to carry this or should I via powerpc.git ? There's
>> > a dependency on another patch that's going into powerpc-next ...
>>
>> I'm sorry. It's been a month ago. Is there any consensus regarding these
>> two
>> patches? Are they going in in the 3.1 merge window?
>
> There have been no response from the Doug, but I just realized we
> haven't CCing their mailing list... oh well, I'll probably send them to
> Linux myself some time next week.

Thank you very much!

-- 
With best wishes
Dmitry
