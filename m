Return-Path: <sudeep.holla@arm.com>
Received: from service87.mimecast.com (service87.mimecast.com [91.220.42.44])
 by ozlabs.org (Postfix) with ESMTP id 9FD922C0142
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jan 2014 06:07:44 +1100 (EST)
Message-ID: <52CEF383.3070405@arm.com>
Date: Thu, 09 Jan 2014 19:07:47 +0000
From: Sudeep Holla <Sudeep.Holla@arm.com>
MIME-Version: 1.0
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH RFC 1/3] drivers: base: support cpu cache information
 interface to userspace via sysfs
References: <1389209168-17189-1-git-send-email-sudeep.holla@arm.com>
 <1389209168-17189-2-git-send-email-sudeep.holla@arm.com>
 <20140108202826.GF8417@kroah.com>
In-Reply-To: <20140108202826.GF8417@kroah.com>
Content-Type: text/plain; charset=WINDOWS-1252
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Ashok Raj <ashok.raj@intel.com>, Rob Herring <robh@kernel.org>,
 "x86@kernel.org" <x86@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Sudeep.Holla@arm.com,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/01/14 20:28, Greg Kroah-Hartman wrote:
> On Wed, Jan 08, 2014 at 07:26:06PM +0000, Sudeep Holla wrote:
>> From: Sudeep Holla <sudeep.holla@arm.com>
>> +#define define_one_ro(_name) \
>> +static struct cache_attr _name =3D \
>> +=09__ATTR(_name, 0444, show_##_name, NULL)
>=20
> In the future, we do have __ATTR_RO(), which should be used instead.
> You should never use __ATTR() on it's own, if at all possible.  I'm
> sweeping the tree for all usages and fixing them slowly up over time.
>=20

Understood, will fix it.

Regards,
Sudeep
