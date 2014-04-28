Return-Path: <felix@linux.vnet.ibm.com>
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3723314009F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Apr 2014 00:39:45 +1000 (EST)
Received: from /spool/local
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <felix@linux.vnet.ibm.com>;
 Mon, 28 Apr 2014 15:39:41 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id A8D562190041
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Apr 2014 15:39:31 +0100 (BST)
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
 [9.149.37.228])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3SEddeH1442296
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Apr 2014 14:39:39 GMT
Received: from d06av02.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av02.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3SEdao7012448
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Apr 2014 08:39:38 -0600
Message-ID: <535E6804.5050508@linux.vnet.ibm.com>
Date: Mon, 28 Apr 2014 16:39:00 +0200
From: Philippe Bergheaud <felix@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Anton Blanchard <anton@samba.org>
Subject: Re: [git pull] Please pull abiv2 branch
References: <20140423124902.5be9dab0@kryten>
In-Reply-To: <20140423124902.5be9dab0@kryten>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: philippe.bergheaud@fr.ibm.com, mikey@neuling.org, amodra@gmail.com,
 rusty@rustcorp.com.au, rostedt@goodmis.org, ulrich.weigand@de.ibm.com,
 paulus@samba.org, mjw@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anton Blanchard wrote:
> Here are the ABIv2 patches rebased against 3.15-rc2.

After recompiling 3.15-rc2 with the ABIv2 patches,
I see the following line in Modules.symvers:

     0x00000000 TOC. vmlinux EXPORT_SYMBOL

Kernel will not load modules because TOC. has no CRC.
Is this expected ? Shouldn't TOC. have a CRC ?

Philippe
