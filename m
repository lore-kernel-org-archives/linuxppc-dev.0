Return-Path: <key@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e36.co.us.ibm.com", Issuer "Equifax" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C3F84B6EE6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Mar 2012 06:07:55 +1100 (EST)
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <key@linux.vnet.ibm.com>;
 Thu, 22 Mar 2012 13:07:53 -0600
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
 [9.17.195.227])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id B8EABC40006
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2012 13:07:49 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q2MJ7iWc096758
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2012 13:07:45 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q2MJ7FvW001912
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2012 13:07:15 -0600
Message-ID: <1332443286.3858.70.camel@key-ThinkPad-W510>
Subject: Re: [PATCH 00/17] Platform Facilities Option and crypto accelerator
 driver
From: Kent Yoder <key@linux.vnet.ibm.com>
To: Kumar Gala <galak@kernel.crashing.org>
Date: Thu, 22 Mar 2012 14:08:06 -0500
In-Reply-To: <C23F031B-1431-4E98-92DC-3EB7E31D2776@kernel.crashing.org>
References: <1332365297.3858.5.camel@key-ThinkPad-W510>
 <C23F031B-1431-4E98-92DC-3EB7E31D2776@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: rcj@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Kumar,

> Is there a reason this isn't in drivers/crypto/

  Other arch-specific dirs have their crypto subdir as well such as
arch/s390.  I was just matching that.

Kent

> - k
