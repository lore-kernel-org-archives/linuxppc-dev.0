Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sP4bv2NxszDqXr
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Aug 2016 09:34:19 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7UNY0tU098343
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Aug 2016 19:34:16 -0400
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
 by mx0b-001b2d01.pphosted.com with ESMTP id 255368ytbc-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Aug 2016 19:34:16 -0400
Received: from localhost
 by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Tue, 30 Aug 2016 20:34:14 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 3D23B1DC0054
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Aug 2016 19:34:03 -0400 (EDT)
Received: from d24av03.br.ibm.com (d24av03.br.ibm.com [9.8.31.95])
 by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7UNYCKu5128402
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Aug 2016 20:34:12 -0300
Received: from d24av03.br.ibm.com (localhost [127.0.0.1])
 by d24av03.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7UNYB31008849
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Aug 2016 20:34:12 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: Dave Young <dyoung@redhat.com>
Cc: kexec@lists.infradead.org, Stewart Smith <stewart@linux.vnet.ibm.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Arnd Bergmann <arnd@arndb.de>, Baoquan He <bhe@redhat.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Vivek Goyal <vgoyal@redhat.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 David Laight <David.Laight@aculab.com>,
 Eric Biederman <ebiederm@xmission.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/2] kexec: extend kexec_file_load system call
Date: Tue, 30 Aug 2016 20:34:09 -0300
In-Reply-To: <20160818081907.GA845@dhcp-128-65.nay.redhat.com>
References: <1470956638-3589-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <1470956638-3589-3-git-send-email-bauerman@linux.vnet.ibm.com>
 <20160818081907.GA845@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <2498282.SqYYr55LTv@hactar>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Dave,

Sorry for the delay, I was trying to get the other patch series ready as I 
mentioned in the other email.

Am Donnerstag, 18 August 2016, 16:19:46 schrieb Dave Young:
> Since Eric was objecting the extension, I think you should convince him,
> but I will review from code point of view.

Thank you very much for your review!
It looks like this series went as far as it can go, though...

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center
