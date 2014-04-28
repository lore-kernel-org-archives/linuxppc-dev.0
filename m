Return-Path: <amodra@gmail.com>
Received: from mail-pa0-f47.google.com (mail-pa0-f47.google.com
 [209.85.220.47])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id F1DAC1400FF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Apr 2014 09:46:59 +1000 (EST)
Received: by mail-pa0-f47.google.com with SMTP id fa1so403660pad.20
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Apr 2014 16:46:57 -0700 (PDT)
Date: Tue, 29 Apr 2014 09:16:50 +0930
From: Alan Modra <amodra@gmail.com>
To: Philippe Bergheaud <felix@linux.vnet.ibm.com>
Subject: Re: [git pull] Please pull abiv2 branch
Message-ID: <20140428234649.GK3397@bubble.grove.modra.org>
References: <20140423124902.5be9dab0@kryten>
 <535E6804.5050508@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <535E6804.5050508@linux.vnet.ibm.com>
Cc: philippe.bergheaud@fr.ibm.com, mikey@neuling.org, rusty@rustcorp.com.au,
 rostedt@goodmis.org, ulrich.weigand@de.ibm.com, paulus@samba.org,
 Anton Blanchard <anton@samba.org>, mjw@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Apr 28, 2014 at 04:39:00PM +0200, Philippe Bergheaud wrote:
> Kernel will not load modules because TOC. has no CRC.
> Is this expected ? Shouldn't TOC. have a CRC ?

TOC. is really .TOC.  (The kernel build process strips off a leading
dot from symbol names.)  .TOC. is a special symbol giving the toc
base, so no, it shouldn't have a CRC.

-- 
Alan Modra
Australia Development Lab, IBM
