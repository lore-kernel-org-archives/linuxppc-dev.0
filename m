Return-Path: <glikely@secretlab.ca>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179]) by ozlabs.org (Postfix) with ESMTP id 08C78B6EFF
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  7 Aug 2010 04:52:14 +1000 (EST)
Received: by gya1 with SMTP id 1so3255406gya.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 06 Aug 2010 11:52:12 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <0A40042D85E7C84DB443060EC44B3FD325420B9123@dekaexchange07.deka.local>
References: <1276617907-10862-1-git-send-email-emillbrandt@dekaresearch.com>
	<20100622230026.GA2453@opensource.wolfsonmicro.com>
	<AANLkTiluyeGSwVSXgTeRxS3hVWTe3Gkn8qHrqbHJFMun@mail.gmail.com>
	<D37786F8-EBA7-4E55-AE83-5D0ABF1E17BF@opensource.wolfsonmicro.com>
	<AANLkTikbHp18uc-idFtEqakoo_0Vdg_rU44xv9uHwkvG@mail.gmail.com>
	<20100803055216.GA25306@rakim.wolfsonmicro.main>
	<0A40042D85E7C84DB443060EC44B3FD325420B9123@dekaexchange07.deka.local>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 6 Aug 2010 12:44:59 -0600
Message-ID: <AANLkTimuW+02aJuK+YcRFTiYdB0=CnLGJs5jfV2=RRfL@mail.gmail.com>
Subject: Re: [PATCH 0/2 v3] mpc5200 ac97 gpio reset
To: Eric Millbrandt <emillbrandt@dekaresearch.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 5, 2010 at 6:59 AM, Eric Millbrandt
<emillbrandt@dekaresearch.com> wrote:
>> -----Original Message-----
>> From: linuxppc-dev-bounces+emillbrandt=3Ddekaresearch.com@lists.ozlabs.o=
rg
>> [mailto:linuxppc-dev-
>> bounces+emillbrandt=3Ddekaresearch.com@lists.ozlabs.org] On Behalf Of Ma=
rk
>> Brown
>> Sent: Tuesday, August 03, 2010 01:52
>> To: Grant Likely
>> Cc: linuxppc-dev@lists.ozlabs.org; Eric Millbrandt
>> Subject: Re: [PATCH 0/2 v3] mpc5200 ac97 gpio reset
>>
>> On Sat, Jul 31, 2010 at 10:42:15PM -0600, Grant Likely wrote:
>> > On Sun, Jun 27, 2010 at 4:01 PM, Mark Brown
>>
>> > > I'm a little concerned with a collision with multi codec here. It'd
>> > > be handy if you could keep it separate in case it needs merging
>> > > into both trees (or we could merge via ASoC only).
>>
>> > Hmmm. =A0Yeah, probably better to take it via your tree then. =A0I've
>> > currently got patch 1 in linux-next, but I'll drop it before asking
>> > benh to pull. =A0Go ahead and add my acked-by.
>>
>> Looks like multi-component is slightly too late for .36 and I don't have
>> the original patch any more since it looked like you were going to be
>> carrying it... =A0could you restore the patch to your tree please?
>
> <ping> Grant, are you going to pick up this series for .36?

Yes, working on it...  :-)

g.
