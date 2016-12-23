Return-Path: <stewart@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tlFYw3BVDzDsgv
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Dec 2016 15:20:52 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uBN4JTPk116440
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Dec 2016 23:20:49 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0b-001b2d01.pphosted.com with ESMTP id 27gm598u0p-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Dec 2016 23:20:49 -0500
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Thu, 22 Dec 2016 21:20:49 -0700
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH RFC] powerpc/powernv: sysfs entry to force full IPL reboot
In-Reply-To: <20161122092258.32514-1-andrew.donnellan@au1.ibm.com>
References: <20161122092258.32514-1-andrew.donnellan@au1.ibm.com>
Date: Fri, 23 Dec 2016 15:20:42 +1100
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87mvfn2s4l.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Andrew Donnellan <andrew.donnellan@au1.ibm.com> writes:
> skiboot now supports "fast reboot", a reboot procedure where skiboot
> reinitialises hardware and loads a new kernel without re-IPLing the
> machine. At present, fast reboot support is still experimental and is not
> enabled by default, however it is intended that it will be enabled by
> default in a near-future release.
>
> There may be some circumstances where the user wants to force a full IPL
> reboot rather than using fast reboot. Add support for the
> OPAL_REBOOT_FULL_IPL reboot type, enabled by writing 1 to
> /sys/firmware/opal/force_full_ipl_reboot. On versions of skiboot that
> implement the OPAL_REBOOT_FULL_IPL reboot type, this will force an IPL. On
> versions that do not, print an error message on reboot and proceed with a
> regular reboot (which could be a full IPL or a fast reboot).
>
> Cc: Stewart Smith <stewart@linux.vnet.ibm.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
>
> ---
>
> Corresponding skiboot patch: http://patchwork.ozlabs.org/patch/697601/

FWIW I've just merged the skiboot patch.

-- 
Stewart Smith
OPAL Architect, IBM.
