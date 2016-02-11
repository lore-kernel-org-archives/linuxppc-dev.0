Return-Path: <robh+dt@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 by lists.ozlabs.org (Postfix) with ESMTP id F14D21A003D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Feb 2016 01:51:10 +1100 (AEDT)
Received: from mail.kernel.org (localhost [127.0.0.1])
 by mail.kernel.org (Postfix) with ESMTP id 585E12017E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Feb 2016 14:51:08 +0000 (UTC)
Received: from mail-yk0-f176.google.com (mail-yk0-f176.google.com
 [209.85.160.176])
 (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id BCF49203C1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Feb 2016 14:51:01 +0000 (UTC)
Received: by mail-yk0-f176.google.com with SMTP id u9so21534878ykd.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Feb 2016 06:51:01 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1454407763-1017-4-git-send-email-gkulkarni@caviumnetworks.com>
References: <1454407763-1017-1-git-send-email-gkulkarni@caviumnetworks.com>
 <1454407763-1017-4-git-send-email-gkulkarni@caviumnetworks.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Thu, 11 Feb 2016 08:50:41 -0600
Message-ID: <CAL_JsqK5HV9yzBE+ANnTw26eVR7Dy+B8OkwQ-7WF8KDa86Fd9g@mail.gmail.com>
Subject: Re: [PATCH v10 3/8] dt, numa: adding numa dt binding implementation.
To: Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>
Cc: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 linux-ia64@vger.kernel.org, linux-metag <linux-metag@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-s390@vger.kernel.org, SH-Linux <linux-sh@vger.kernel.org>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 Will Deacon <Will.Deacon@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>,
 Grant Likely <grant.likely@linaro.org>,
 Leif Lindholm <leif.lindholm@linaro.org>, rfranz@cavium.com,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, Mark Salter <msalter@redhat.com>,
 Steve Capper <steve.capper@linaro.org>, Hanjun Guo <hanjun.guo@linaro.org>,
 Al Stone <al.stone@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 Pawel Moll <pawel.moll@arm.com>,
 Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>,
 Rafael Wysocki <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
 Marc Zyngier <marc.zyngier@arm.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Tony Luck <tony.luck@intel.com>, fenghua.yu@intel.com,
 James Hogan <james.hogan@imgtec.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 "x86@kernel.org" <x86@kernel.org>, Jon Masters <jonathan@jonmasters.org>,
 Robert Richter <rrichter@cavium.com>, Prasun.Kapoor@caviumnetworks.com,
 Ganapatrao Kulkarni <gpkulkarni@gmail.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 2, 2016 at 4:09 AM, Ganapatrao Kulkarni
<gkulkarni@caviumnetworks.com> wrote:
> dt node parsing for numa topology is done using device property
> numa-node-id and device node distance-map.

How is it that powerpc doesn't need flat DT parsing for NUMA? Both
arches are memblock based and the binding is similar IIRC, so you
should be able to find a way to do this with the unflattened tree.
Ideally, there should be some common code shared as well.

Do you have a git tree with this series?

Rob
