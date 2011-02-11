Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20110211124132.2ae965d7@udp111988uds>
References: <1296861941-3370-1-git-send-email-meador_inge@mentor.com>
	<AANLkTinda9TX+Ng=kL-HHLOdqRnUZ6uitQKyZcRUHVco@mail.gmail.com>
	<4D54986A.60907@mentor.com>
	<AANLkTikPgqgnWDOz+H5OXK7Sc=J67xOF3NMNkfDErocu@mail.gmail.com>
	<9F6FE96B71CF29479FF1CDC8046E15030C485D@039-SN1MPN1-002.039d.mgd.msft.net>
	<20110211124132.2ae965d7@udp111988uds>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 11 Feb 2011 11:59:41 -0700
Message-ID: <AANLkTik8jp4fuNzoRHgkJ8fwXkPv9j6uK4uORswk+8Mo@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] powerpc: Open PIC binding and "pic-no-reset"
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "devicetree-discuss@lists.ozlabs.org"
	<devicetree-discuss@lists.ozlabs.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	Meador Inge <meadori@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Feb 11, 2011 at 11:41 AM, Scott Wood <scottwood@freescale.com> wrot=
e:
> On Fri, 11 Feb 2011 14:58:13 +0000
> Yoder Stuart-B08248 <B08248@freescale.com> wrote:
>
>>
>>
>> > -----Original Message-----
>> > From: Meador Inge [mailto:meadori@gmail.com]
>> > Sent: Thursday, February 10, 2011 9:26 PM
>> > To: Benjamin Herrenschmidt
>> > Cc: Yoder Stuart-B08248; devicetree-discuss@lists.ozlabs.org; linuxppc=
-
>> > dev@lists.ozlabs.org
>> > Subject: Re: [PATCH v3 0/4] powerpc: Open PIC binding and "pic-no-rese=
t"
>> >
>> > From the feedback I have received so far, the fundamental ideas in thi=
s
>> > patch set are sane. =A0However, the following issues still need agreem=
ent:
>> >
>> > =A0=A0 =A01. What should be the name of the no reset property?
>> > =A0=A0 =A0 =A0 "pic-no-reset" or "no-reset"?
>> > =A0=A0 =A02. Should we just keep the existing protected sources implem=
entation
>> > =A0=A0 =A0 =A0 in place?
>> >
>> > For (1), I prefer "no-reset".
>>
>> I also prefer plain "no-reset". =A0The property is on a pic node so
>> "pic" on the property seems redundant.
>
> It's not redundant, it's namespacing. =A0Before there was a generic "stat=
us"
> property, someone who wanted a device-specific "status" could have made
> the same argument. =A0Usually we use a vendor prefix to avoid that proble=
m,
> but that won't work here.

Yes, it is a namespace issue.  Please keep the 'pic-' or some other
prefix to reduce the likelyhood of a global namespace clash.
'no-reset' is vanilla enough that it is conceivable it could be
defined as part of a common binding sometime in the future.

g.
