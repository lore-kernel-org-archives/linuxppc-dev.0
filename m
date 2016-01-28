Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1490E1A1ADD
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jan 2016 13:42:09 +1100 (AEDT)
Received: by mail-pf0-x241.google.com with SMTP id n128so1272710pfn.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jan 2016 18:42:08 -0800 (PST)
Date: Thu, 28 Jan 2016 13:41:57 +1100
From: Balbir Singh <bsingharora@gmail.com>
To: Torsten Duwe <duwe@lst.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, Michael Ellerman
 <mpe@ellerman.id.au>, Jiri Kosina <jkosina@suse.cz>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 live-patching@vger.kernel.org
Subject: Re: [PATCH v6 0/9] ftrace with regs + live patching for ppc64 LE
 (ABI v2)
Message-ID: <20160128134157.1ac3d344@cotter.ozlabs.ibm.com>
In-Reply-To: <20160127121904.GB32095@lst.de>
References: <20160125170459.14DB7692CE@newverein.lst.de>
 <20160127215112.080eec56@cotter.ozlabs.ibm.com>
 <20160127121904.GB32095@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 27 Jan 2016 13:19:04 +0100
Torsten Duwe <duwe@lst.de> wrote:

> Thanks! Make sure you use a compiler that can disable -mprofile-kernel with "notrace".

gcc-6? I have gcc-5.2.1

Balbir Singh.
