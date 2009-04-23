Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.238])
	by ozlabs.org (Postfix) with ESMTP id 2092DDE11F
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Apr 2009 23:55:11 +1000 (EST)
Received: by rv-out-0506.google.com with SMTP id f9so449604rvb.9
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Apr 2009 06:55:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <DC91BA72-AF10-41DD-B610-EDEFD106A811@kernel.crashing.org>
References: <A6732FD8-FBC6-420F-9318-CC111D266993@kernel.crashing.org>
	<ed82fe3e0904221235i51fb75dap44b1fad09a10ea91@mail.gmail.com>
	<49EF7B11.2000006@freescale.com> <49EF7B1C.2080105@freescale.com>
	<282847E1-AE1A-44EF-9D18-AF2884105FA5@kernel.crashing.org>
	<49EF8D42.7010104@freescale.com>
	<DC91BA72-AF10-41DD-B610-EDEFD106A811@kernel.crashing.org>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 23 Apr 2009 07:54:55 -0600
Message-ID: <fa686aa40904230654u4e3908c5v567a2cf473fce6ec@mail.gmail.com>
Subject: Re: removing get_immrbase()??
To: Kumar Gala <galak@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Scott Wood <scottwood@freescale.com>,
	Linuxppc-dev Development <linuxppc-dev@ozlabs.org>,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 22, 2009 at 3:39 PM, Kumar Gala <galak@kernel.crashing.org> wro=
te:
>
> On Apr 22, 2009, at 4:33 PM, Timur Tabi wrote:
>
>> Kumar Gala wrote:
>>
>>> I disagree. =A0If you update your kernel you should update your device
>>> tree (thus we have .dts in the kernel tree and not somewhere else).
>>
>> Is this a new policy? =A0I was under the impression that supporting olde=
r
>> device trees, if not too inconvenient, is desirable. =A0I've nack'd
>> patches before that broke backwards compatibility unnecessarily.
>
> The specific issue I'm talking about is the addition of new nodes that mi=
ght
> break old device trees. =A0I have no desire to try and say that I can't a=
dd
> new nodes and code related to them just because old device tree's didn't
> have them.

Ah... yes, you're right.  Never mind my previous reply.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
