Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C5163B6F81
 for <linuxppc-dev@ozlabs.org>; Tue,  1 Nov 2011 00:44:52 +1100 (EST)
Subject: Re: [RFC][PATCH 1/2] uio: allow drivers to override the pgprot for
 mmap
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20111029063809.GC2280@kroah.com>
Date: Mon, 31 Oct 2011 08:44:40 -0500
Message-Id: <A4AFF4A3-0F5F-430C-BD34-CC043C0644AB@kernel.crashing.org>
References: <1319817030-23992-1-git-send-email-galak@kernel.crashing.org>
 <20111028214812.GD23092@local> <20111029063809.GC2280@kroah.com>
To: Greg KH <greg@kroah.com>
Cc: linuxppc-dev@ozlabs.org, "Hans J. Koch" <hjk@hansjkoch.de>,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 29, 2011, at 1:38 AM, Greg KH wrote:

> On Fri, Oct 28, 2011 at 11:48:12PM +0200, Hans J. Koch wrote:
>> On Fri, Oct 28, 2011 at 10:50:29AM -0500, Kumar Gala wrote:
>>> For some devices, the default behavior of pgprot_noncached() is not
>>> appropriate for all of its mappable regions. This provides a means =
for
>>> the kernel side of the UIO driver to override the flags without =
having
>>> to implement its own full mmap callback.
>>=20
>> Thanks for also providing an example driver showing the use of this.
>> You should also post this driver in a mainline-ready version, I'm a =
bit
>> uncomfortable with adding a new function pointer without having any =
users.
>=20
> I'm more than "uncomfortable", I'll refuse to take any such patch =
unless
> there is a in-kernel user, otherwise it makes no sense to add the
> pointer at all.
>=20
> thanks,
>=20
> greg k-h

I'm in agreement with this view.  I wanted to post this to make sure the =
direction we took was ok so when the upstream driver is posted this =
patch / change isn't a concern.

- k=
