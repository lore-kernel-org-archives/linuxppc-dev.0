Return-Path: <JBeulich@novell.com>
Received: from vpn.id2.novell.com (vpn.id2.novell.com [195.33.99.129])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "emea1-mh.id2.novell.com", Issuer "APPS" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id D1A89B7185
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 18 Nov 2010 19:05:45 +1100 (EST)
Message-Id: <4CE4E7A10200007800022F33@vpn.id2.novell.com>
Date: Thu, 18 Nov 2010 07:45:21 +0000
From: "Jan Beulich" <JBeulich@novell.com>
To: "Stephen Rothwell" <sfr@canb.auug.org.au>,
	"Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Subject: Re: linux-next: build warning in Linus' tree
References: <20101025135237.337b8321.sfr@canb.auug.org.au>
	<1287978429-18542-1-git-send-email-lacombar@gmail.com>
	<20101025170322.851780f3.sfr@canb.auug.org.au>
	<1290052544.32570.1.camel@pasglop>
In-Reply-To: <1290052544.32570.1.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org, "H.Peter Anvin" <hpa@linux.intel.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Arnaud Lacombe <lacombar@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>>> On 18.11.10 at 04:55, Benjamin Herrenschmidt <benh@kernel.crashing.org>=
 wrote:
> On Mon, 2010-10-25 at 17:03 +1100, Stephen Rothwell wrote:
>> Hi Arnaud,
>>=20
>> On Sun, 24 Oct 2010 23:47:09 -0400 Arnaud Lacombe <lacombar@gmail.com> =
wrote:
>> >
>> > The following patch should fix this warning.
>>=20
>> I think the following is preferable.  Not tested yet, I will test
>> tomorrow and submit properly then.
>=20
> I agree. Tho I don't understand the original problem. Both definitions
> have no parenthesis for me and I don't see warnings, or am I missing
> some changes still in -next that cause this ?

There had been parentheses for a short while, but them causing
problems for at least one other arch, they got removed again.

Jan
