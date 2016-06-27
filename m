Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rdZhY18sqzDqmB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 02:51:24 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5RGnBsb107818
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 12:51:22 -0400
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23sm3txtdq-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 12:51:22 -0400
Received: from localhost
 by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Mon, 27 Jun 2016 13:51:20 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id E3DE81DC006E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 12:51:09 -0400 (EDT)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5RGpHP225755928
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 13:51:17 -0300
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
 by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5RGpHrh032374
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 13:51:17 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: Dave Young <dyoung@redhat.com>
Cc: kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH v3 3/9] kexec_file: Factor out kexec_locate_mem_hole from
 kexec_add_buffer.
Date: Mon, 27 Jun 2016 13:51:16 -0300
In-Reply-To: <5428891.iJNV8CI1We@hactar>
References: <1466538521-31216-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <20160627161948.GA5876@dhcp-128-65.nay.redhat.com>
 <5428891.iJNV8CI1We@hactar>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <1915759.R1Bukpmjaj@hactar>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Am Montag, 27 Juni 2016, 13:37:58 schrieb Thiago Jung Bauermann:
> Should I add a separate top_down argument to kexec_locate_mem_hole to
> control if the memory walk should be from top to bottom, and then the
> bottom_up member of struct kexec_buf controls where inside each memory
> region the memory hole will be allocated?

Er, "...the bottom_up member of struct kexec_buf..." should read "...the 
top_down member of struct kexec buf...".

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center
