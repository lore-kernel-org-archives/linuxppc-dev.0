Return-Path: <mrochs@linux.vnet.ibm.com>
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qpXMV5Z5XzDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 01:37:26 +1000 (AEST)
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mrochs@linux.vnet.ibm.com>;
 Mon, 18 Apr 2016 11:37:24 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 1A99DC90042
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Apr 2016 11:37:15 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3IFbKBv41156726
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Apr 2016 15:37:20 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3IFbJbA027955
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Apr 2016 11:37:20 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH] cxl: static-ify variables to fix sparse warnings
From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
In-Reply-To: <1460955830-27267-1-git-send-email-andrew.donnellan@au1.ibm.com>
Date: Mon, 18 Apr 2016 10:37:18 -0500
Cc: linuxppc-dev@lists.ozlabs.org, imunsie@au1.ibm.com,
 fbarrat@linux.vnet.ibm.com, clombard@linux.vnet.ibm.com
Message-Id: <34DBEEF3-B190-42AE-BE16-4EC2BEBD40BB@linux.vnet.ibm.com>
References: <1460955830-27267-1-git-send-email-andrew.donnellan@au1.ibm.com>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Reviewed-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
