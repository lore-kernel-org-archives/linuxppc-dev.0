Return-Path: <gpkulkarni@gmail.com>
Received: from mail-wm0-x241.google.com (mail-wm0-x241.google.com
 [IPv6:2a00:1450:400c:c09::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AEE601A030F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jan 2016 04:12:20 +1100 (AEDT)
Received: by mail-wm0-x241.google.com with SMTP id 128so2825212wmz.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jan 2016 09:12:20 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20160128143925.GC775@arm.com>
References: <1453134965-6125-1-git-send-email-gkulkarni@caviumnetworks.com>
 <1453134965-6125-4-git-send-email-gkulkarni@caviumnetworks.com>
 <20160126203603.GC17600@localhost> <20160128143925.GC775@arm.com>
Date: Thu, 28 Jan 2016 22:42:17 +0530
Message-ID: <CAFpQJXVhEVw7vSq233wfkOGkTanf-msO+PEcWJ2OVAFUhn7n+w@mail.gmail.com>
Subject: Re: [PATCH v9 3/6] arm64/arm, numa, dt: adding numa dt binding
 implementation for arm64 platforms.
From: Ganapatrao Kulkarni <gpkulkarni@gmail.com>
To: Will Deacon <will.deacon@arm.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
 Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-pci@vger.kernel.org,
 linux-ia64@vger.kernel.org, linux-metag@vger.kernel.org,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-arch@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>,
 Grant Likely <grant.likely@linaro.org>,
 Leif Lindholm <leif.lindholm@linaro.org>, rfranz@cavium.com,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 "msalter@redhat.com" <msalter@redhat.com>,
 Rob Herring <robh+dt@kernel.org>, Steve Capper <steve.capper@linaro.org>,
 Hanjun Guo <hanjun.guo@linaro.org>, Al Stone <al.stone@linaro.org>,
 Arnd Bergmann <arnd@arndb.de>, Pawel Moll <pawel.moll@arm.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
 Marc Zyngier <marc.zyngier@arm.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Bjorn Helgaas <bhelgaas@google.com>, tony.luck@intel.com,
 fenghua.yu@intel.com, james.hogan@imgtec.com,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "tglx@linutronix.de" <tglx@linutronix.de>, mingo@redhat.com,
 hpa@zytor.com, x86@kernel.org, Jon Masters <jonathan@jonmasters.org>,
 Robert Richter <rrichter@cavium.com>,
 Prasun Kapoor <Prasun.Kapoor@caviumnetworks.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Will,


On Thu, Jan 28, 2016 at 8:09 PM, Will Deacon <will.deacon@arm.com> wrote:
> On Tue, Jan 26, 2016 at 02:36:04PM -0600, Bjorn Helgaas wrote:
>> Subject is "arm64/arm, numa, dt: adding ..."  What is the significance
>> of the "arm" part?  The other patches only mention "arm64".
>>
>> General comment: the code below has little, if anything, that is
>> actually arm64-specific.  Maybe this is the first DT-based NUMA
>> platform?  I don't see other similar code for other arches, so maybe
>> it's too early to try to generalize it, but we should try to avoid
>> adding duplicates of this code if/when other arches do show up.
>
> Having it in the core code would allow us to share it with arch/arm/
> fairly straightforwardly.
This binding can be used for arm too.
however at this moment it is the need of arm64 platforms.
can we please keep this to arm64 as it's too early to try to
generalize it(as Bjorn suggested)
I prefer to keep it as it is, otherwise ok.
Please suggest.
>
> Will
thanks
Ganapat
