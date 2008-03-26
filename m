Return-Path: <tur@semihalf.com>
Received: from semihalf.com (semihalf.com [206.130.101.55])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AAE99DE264
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2008 08:34:15 +1100 (EST)
Message-ID: <47EAC0E8.8070301@semihalf.com>
Date: Wed, 26 Mar 2008 22:32:24 +0100
From: Bartlomiej Sieka <tur@semihalf.com>
MIME-Version: 1.0
To: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [RESEND][POWERPC] mpc5200: Amalgamated dts fixes and updates
References: <47E2723D.1090101@grandegger.com>
	<47E281B6.20702@denx.de>	<fa686aa40803201650t289cd800gfda389b192c1834c@mail.gmail.com>	<47E2FC3E.1020705@semihalf.com>	<fa686aa40803201720l3e42c983se121ebc257c89912@mail.gmail.com>	<20080321235633.GB345@frozen.semihalf.com>	<fa686aa40803212014ne560615sfcdef542d59eb6cb@mail.gmail.com>	<20080326194526.GA17424@frozen.semihalf.com>
	<fa686aa40803261335q2b8af09cw6f05dc0cf905d0b5@mail.gmail.com>
	<47EAB687.5040702@grandegger.com>
In-Reply-To: <47EAB687.5040702@grandegger.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Anatolij Gustschin <agust@denx.de>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Wolfgang Grandegger wrote:
> Grant Likely wrote:
>> On Wed, Mar 26, 2008 at 1:45 PM, Bartlomiej Sieka <tur@semihalf.com> wrote:
>>>     The bulk of this patch is taken from
>>>     http://patchwork.ozlabs.org/linuxppc/patch?q=Balakowicz&id=16197, with few
>>>     other updates.
>>>
>>>     Signed-off-by: Marian Balakowicz <m8@semihalf.com>
>>>  ---
>>>  Addressed comments from the list; would appreciate picking up as the patch
>>>  fixes booting issue on TQM5200 and Motion-PRO (cm5200 changes are analogous,
>>>  but not tested due to hardware unavailability).
>> I see one obvious error; but other than that it looks good.  Once that
>> is fixed I can recommend for Paul to pick it up for .25.  It's just
>> dts changes, so I don't expect it to be a problem.
>>
>> Cheers,
[...]
> And whats about the two CAN nodes for tqm5200.dts? Do we have them already?

Hello Wolfgang,

patchwork shows your updates as "Awaiting Upstream"
(http://patchwork.ozlabs.org/linuxppc/patch?q=Grandegger&id=17444), so I
haven't included them in my patch. I suppose you should follow-up with
Grant/Paulus on the status?

Regards,
Bartlomiej
