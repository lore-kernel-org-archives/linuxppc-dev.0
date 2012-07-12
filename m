Return-Path: <dave@linux.vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e4.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id ED8C82C0220
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jul 2012 23:42:10 +1000 (EST)
Received: from /spool/local
 by e4.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <dave@linux.vnet.ibm.com>;
 Thu, 12 Jul 2012 09:42:07 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 18A5138C80D3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jul 2012 09:40:43 -0400 (EDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q6CDee5b390280
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jul 2012 09:40:41 -0400
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q6CDeZto030671
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jul 2012 07:40:39 -0600
Message-ID: <4FFED3CE.7030108@linux.vnet.ibm.com>
Date: Thu, 12 Jul 2012 06:40:30 -0700
From: Dave Hansen <dave@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
Subject: Re: [RFC PATCH v3 3/13] memory-hotplug : unify argument of
 firmware_map_add_early/hotplug
References: <4FFAB0A2.8070304@jp.fujitsu.com>
 <4FFAB17F.2090209@jp.fujitsu.com> <4FFD9C08.2070502@linux.vnet.ibm.com>
 <4FFE5816.6070102@jp.fujitsu.com>
In-Reply-To: <4FFE5816.6070102@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-2022-JP
Cc: len.brown@intel.com, wency@cn.fujitsu.com, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, paulus@samba.org,
 minchan.kim@gmail.com, kosaki.motohiro@jp.fujitsu.com, rientjes@google.com,
 cl@linux.com, linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org,
 liuj97@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/11/2012 09:52 PM, Yasuaki Ishimatsu wrote:
> Does the following patch include your comment? If O.K., I will separate
> the patch from the series and send it for bug fix.

Looks sane to me.  It does now mean that the calling conventions for
some of the other firmware_map*() functions are different, but I think
that's OK since they're only used internally to memmap.c.
