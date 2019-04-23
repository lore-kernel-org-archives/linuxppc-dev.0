Return-Path: <SRS0=/W8y=SZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 780B7C10F03
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 16:42:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01DB420645
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 16:41:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01DB420645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44pTkF6jZ7zDqGc
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 02:41:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.167.195; helo=mail-oi1-f195.google.com;
 envelope-from=rjwysocki@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-oi1-f195.google.com (mail-oi1-f195.google.com
 [209.85.167.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44pTh15ZHzzDqG6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2019 02:40:01 +1000 (AEST)
Received: by mail-oi1-f195.google.com with SMTP id v10so11842020oib.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2019 09:40:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+K32CEJySJHRZYnsViCh90blV19hUxk8RW9cAv6Ulo0=;
 b=NCgzlk0hI9fTux3O0EHZ8CU9sm95R0A2AlJ2PyIGOrLU+AiKfJQJf8sEGmge1Bgwb4
 gchxjnu8ROb6WED3T5yTN3Ezav3DHP27l1ZFRHh2e54sYbwQGMFpF6divznXLJEa0VlI
 kYcem/U4MmVCkgGXoPb9gp6WxB7QJonBmcqz5ggeMsrdIrRfYOIFnLydEbhefSNPAom3
 q87FiHtaZVdVgu0zmQMqFHrYmMkBb34YykfbMhMQmWh8kQeU2kJ6IBZ9ze1lbfrtXzhU
 mJYiaG+N75muT9gaBiFvOWe9+bC4azjWew0DMlsFFoTpTwoexRXwgHfPMv0Oo15qyEcr
 PQ1Q==
X-Gm-Message-State: APjAAAWQD535wj6v8dfyuvTxkvUEmdIBKuXHfG+hbRoJy8hOQYsbE9ae
 qXmWc2vNAaoRxh6czdOZeBkW0BpuP4+WZnIce2U=
X-Google-Smtp-Source: APXvYqyjp5DtSCtDUG+rmnZI31mrPN2qE3z63KQ1nAPWx58ynDjdfFmvDo+BMIXoWwqZdvHAAtJAYKpmM6dQRHFO+xE=
X-Received: by 2002:aca:ab06:: with SMTP id u6mr2199750oie.68.1556037598459;
 Tue, 23 Apr 2019 09:39:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190423162932.21428-1-changbin.du@gmail.com>
In-Reply-To: <20190423162932.21428-1-changbin.du@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 23 Apr 2019 18:39:47 +0200
Message-ID: <CAJZ5v0jPyaGQcDfpW5b7A-_3bvkfL78MxFmPtjwCGZ4-=KwUwg@mail.gmail.com>
Subject: Re: [PATCH v4 00/63] Include linux ACPI/PCI/X86 docs into Sphinx TOC
 tree
To: Changbin Du <changbin.du@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Fenghua Yu <fenghua.yu@intel.com>,
 the arch/x86 maintainers <x86@kernel.org>,
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>, linux-gpio@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Apr 23, 2019 at 6:30 PM Changbin Du <changbin.du@gmail.com> wrote:
>
> Hi Corbet and All,
> The kernel now uses Sphinx to generate intelligent and beautiful documentation
> from reStructuredText files. I converted all of the Linux ACPI/PCI/X86 docs to
> reST format in this serias.
>
> In this version I combined ACPI and PCI docs, and added new x86 docs conversion.

I'm not sure if combining all three into one big patch series has been
a good idea, honestly.

It would have been easier to review and handle otherwise.

For one, I'd like to handle the ACPI part of it myself if Jon doesn't mind that.

Thanks,
Rafael
