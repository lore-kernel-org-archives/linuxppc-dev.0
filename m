Return-Path: <sudeep.karkadanagesha@arm.com>
Received: from service87.mimecast.com (service87.mimecast.com [91.220.42.44])
 by ozlabs.org (Postfix) with ESMTP id 279212C027A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Aug 2013 22:44:52 +1000 (EST)
Message-ID: <520E1EC8.1010001@arm.com>
Date: Fri, 16 Aug 2013 13:44:56 +0100
From: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC PATCH 3/4] powerpc: refactor of_get_cpu_node to support
 other architectures
References: <1374492747-13879-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376586580-5409-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376586580-5409-4-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376628563.4255.137.camel@pasglop> <520DE753.8090601@arm.com>
 <1376656351.25016.2.camel@pasglop>
In-Reply-To: <1376656351.25016.2.camel@pasglop>
Content-Type: text/plain; charset=UTF-8
Cc: Jonas Bonn <jonas@southpole.se>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Michal Simek <monstr@monstr.eu>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>,
 "microblaze-uclinux@itee.uq.edu.au" <microblaze-uclinux@itee.uq.edu.au>,
 "linux@openrisc.net" <linux@openrisc.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "rob.herring@calxeda.com" <rob.herring@calxeda.com>,
 "Rafael J. Wysocki" <rjw@sisk.pl>,
 "grant.likely@linaro.org" <grant.likely@linaro.org>,
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

On 16/08/13 13:32, Benjamin Herrenschmidt wrote:
> On Fri, 2013-08-16 at 09:48 +0100, Sudeep KarkadaNagesha wrote:
>=20
>>> Naming is a bit gross. You might want to make it clearer that
>>> we are talking about CPU IDs in the device-tree here.
>>>
>> Any particular preference to the name or just a note is sufficient.
>> Also unlike PPC, in ARM we don't set hard processor id value based
>> values read from device tree. DT must contain the values matching to the
>> hardware ID registers.
>=20
> This is exactly the same on ppc. We don't "set" HW values. The
> device-tree content matches the HW internals. Some processors have a
> "PIR" register as well which contains the HW value, in this case the
> device-tree must contain the same value as the PIR on that processor.
>=20
Ok, I misread the function 'set_hard_smp_processor_id' function.
BTW, you didn't mention if you are OK by just have this clearly
documented in the function and/or you have any preference/better name.

I will send the next version based on that. I have even compile tested
:) now on PPC.

Regards,
Sudeep
