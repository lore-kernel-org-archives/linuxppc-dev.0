Return-Path: <SRS0=N2pq=UR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86203C31E51
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Jun 2019 12:44:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EC8320679
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Jun 2019 12:43:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EC8320679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45Snnn3XQFzDqHW
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Jun 2019 22:43:57 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45Snhn3p8kzDq9j
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2019 22:39:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 45Snhl0Bsrz9sCJ;
 Tue, 18 Jun 2019 22:39:34 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Jonathan Corbet <corbet@lwn.net>,
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: [PATCH v4 19/28] docs: powerpc: convert docs to ReST and rename
 to *.rst
In-Reply-To: <20190614143635.3aff154d@lwn.net>
References: <cover.1560361364.git.mchehab+samsung@kernel.org>
 <63560c1ee7174952e148a353840a17969fe0be2d.1560361364.git.mchehab+samsung@kernel.org>
 <20190614143635.3aff154d@lwn.net>
Date: Tue, 18 Jun 2019 22:39:32 +1000
Message-ID: <87blyvoynv.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 linux-pci@vger.kernel.org, Oliver O'Halloran <oohall@gmail.com>,
 Qiang Zhao <qiang.zhao@nxp.com>, linux-scsi@vger.kernel.org,
 Jiri Slaby <jslaby@suse.com>, Linas Vepstas <linasvepstas@gmail.com>,
 Andrew Donnellan <ajd@linux.ibm.com>,
 Mauro Carvalho Chehab <mchehab@infradead.org>,
 "Manoj N. Kumar" <manoj@linux.ibm.com>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-arm-kernel@lists.infradead.org, "Matthew R. Ochs" <mrochs@linux.ibm.com>,
 Uma Krishnan <ukrishn@linux.ibm.com>, Sam Bobroff <sbobroff@linux.ibm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Li Yang <leoyang.li@nxp.com>, Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.ibm.com>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Jonathan Corbet <corbet@lwn.net> writes:
> On Wed, 12 Jun 2019 14:52:55 -0300
> Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:
>
>> Convert docs to ReST and add them to the arch-specific
>> book.
>> 
>> The conversion here was trivial, as almost every file there
>> was already using an elegant format close to ReST standard.
>> 
>> The changes were mostly to mark literal blocks and add a few
>> missing section title identifiers.
>> 
>> One note with regards to "--": on Sphinx, this can't be used
>> to identify a list, as it will format it badly. This can be
>> used, however, to identify a long hyphen - and "---" is an
>> even longer one.
>> 
>> At its new index.rst, let's add a :orphan: while this is not linked to
>> the main index.rst file, in order to avoid build warnings.
>> 
>> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
>> Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com> # cxl
>
> This one fails to apply because ...
>
> [...]
>
>> diff --git a/Documentation/PCI/pci-error-recovery.rst b/Documentation/PCI/pci-error-recovery.rst
>> index 83db42092935..acc21ecca322 100644
>> --- a/Documentation/PCI/pci-error-recovery.rst
>> +++ b/Documentation/PCI/pci-error-recovery.rst
>> @@ -422,3 +422,24 @@ That is, the recovery API only requires that:
>>     - drivers/net/cxgb3
>>     - drivers/net/s2io.c
>>     - drivers/net/qlge
>> +
>> +>>> As of this writing, there is a growing list of device drivers with
>> +>>> patches implementing error recovery. Not all of these patches are in
>> +>>> mainline yet. These may be used as "examples":
>> +>>>
>> +>>> drivers/scsi/ipr
>> +>>> drivers/scsi/sym53c8xx_2
>> +>>> drivers/scsi/qla2xxx
>> +>>> drivers/scsi/lpfc
>> +>>> drivers/next/bnx2.c
>> +>>> drivers/next/e100.c
>> +>>> drivers/net/e1000
>> +>>> drivers/net/e1000e
>> +>>> drivers/net/ixgb
>> +>>> drivers/net/ixgbe
>> +>>> drivers/net/cxgb3
>> +>>> drivers/net/s2io.c
>> +>>> drivers/net/qlge  
>
> ...of this, which has the look of a set of conflict markers that managed
> to get committed...?

I don't think so.

There's some other uses of >>> in that file, eg about line 162:

  >>> The current powerpc implementation assumes that a device driver will
  >>> *not* schedule or semaphore in this routine; the current powerpc
  >>> implementation uses one kernel thread to notify all devices;
  >>> thus, if one device sleeps/schedules, all devices are affected.
  >>> Doing better requires complex multi-threaded logic in the error
  >>> recovery implementation (e.g. waiting for all notification threads
  >>> to "join" before proceeding with recovery.)  This seems excessively
  >>> complex and not worth implementing.


So it's just an odd choice of emphasis device I think.

cheers
