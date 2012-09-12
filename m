Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A25252C007D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2012 22:13:53 +1000 (EST)
Subject: Re: [PATCH 2/3] powerpc/esdhc: add property to disable the CMD23
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <110EED8CC96DFC488B7E717A2027A27C17701A@039-SN1MPN1-002.039d.mgd.msft.net>
Date: Wed, 12 Sep 2012 07:13:41 -0500
Message-Id: <8B1F0805-759E-417A-B787-40DF197896F3@kernel.crashing.org>
References: <1347347565-17474-1-git-send-email-Chang-Ming.Huang@freescale.com>
 <1347347565-17474-2-git-send-email-Chang-Ming.Huang@freescale.com>
 <20120911075429.GA27028@lizard> <20120911080457.GA28235@lizard>
 <110EED8CC96DFC488B7E717A2027A27C176170@039-SN1MPN1-002.039d.mgd.msft.net>
 <6D8C87BA-CA06-4215-94F5-63EBF5162B0A@kernel.crashing.org>
 <2A6FCAE3-288F-4972-90C0-15105932F13E@kernel.crashing.org>
 <87k3w0y5yn.fsf@octavius.laptop.org>
 <FC22FA36-B2CF-49C2-A0B1-8A0EA614B9CB@kernel.crashing.org>
 <87liggwa1w.fsf@octavius.laptop.org>
 <110EED8CC96DFC488B7E717A2027A27C17701A@039-SN1MPN1-002.039d.mgd.msft.net>
To: Huang Changming-R66093 <R66093@freescale.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 Chris Ball <cjb@laptop.org>,
 "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>,
 Anton Vorontsov <cbouatmailru@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sep 12, 2012, at 1:18 AM, Huang Changming-R66093 wrote:

>=20
>=20
> Best Regards
> Jerry Huang
>=20
>=20
>> -----Original Message-----
>> From: Chris Ball [mailto:cjb@laptop.org]
>> Sent: Wednesday, September 12, 2012 4:59 AM
>> To: Kumar Gala
>> Cc: Huang Changming-R66093; linuxppc-dev@lists.ozlabs.org list; =
linux-
>> mmc@vger.kernel.org; Anton Vorontsov
>> Subject: Re: [PATCH 2/3] powerpc/esdhc: add property to disable the =
CMD23
>>=20
>> Hi,
>>=20
>> On Tue, Sep 11 2012, Kumar Gala wrote:
>>> thanks for the info.  Do you know what's required on controller side
>>> to handle cards that support CMD23?
>>>=20
>>> I'm trying to figure out if older controller's on FSL SoCs are =
missing
>>> some feature to allow CMD23 to work (vs Auto-CMD23).
>>=20
>> It seems plausible that it's just not implemented on these =
controllers.
>> It's a little strange, since the command's been specified for so long =
and
>> we haven't seen any other controllers with problems.  The patch would =
be
>> correct if this is true.
>>=20
>=20
> I didn't find any description about it, but after testing on FSL =
silicones, I got this result:
> Some silicones support this command, and some silicones don't support =
it, which will cause I/O error.

Can you list out which SoCs support it and which don't.  Having this =
list will be useful in understanding which controller versions supported =
it.

- k=
